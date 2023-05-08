import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import '../../shared/utils/image_picker.dart';
import '../../shared/utils/initial_data.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/date_field.dart';
import '../../widgets/inputs/select_field.dart';

class CreateDocumentScreen extends StatefulWidget {
  const CreateDocumentScreen({super.key});
  static const route = 'document/upload';

  @override
  State<CreateDocumentScreen> createState() => _CreateDocumentScreenState();
}

class DocType {
  late int id;
  late String name;
  DocType({required this.id, required this.name});
  static Iterable<DocType> getList(List<dynamic> data) {
    return data.map((e) => DocType(id: e['id'], name: e['name']));
  }
}

class _CreateDocumentScreenState extends State<CreateDocumentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _image;
  bool loading = false;
  Iterable<DocType> docTypeList = [];
  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    setState(() {
      loading = true;
    });
    http.docType().then((value) {
      setState(() {
        loading = false;
      });
      if (!value.success) {
        SnackBarMessage.errorSnackbar(context, value.message);
      } else {
        var docType = value.data['data']['document_types'];
        if (docType != null) {
          setState(() {
            docTypeList = DocType.getList(docType);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        text: 'Upload Document',
        page: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 60),
            child: Column(children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColorScheme().black90,
                      letterSpacing: 0.1),
                  children: [
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4),
                      child: Icon(
                        Icons.info_outline,
                        color: HexColor('#B3261E'),
                        size: 19,
                      ),
                    )),
                    const TextSpan(
                        text: 'Note: ',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const TextSpan(
                        text:
                            'Uploaded documents will be verified by  staff member before they are visible to both nurses and facilities'),
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState!.save();
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: const {
                      'document_type_id': '',
                      'title': "",
                      "notes": '',
                    },
                    skipDisabled: true,
                    child: Column(
                      children: [
                        AppSelectField(
                          error: _formKey.currentState
                              ?.fields['document_type_id']?.errorText,
                          title: 'What is your document type?',
                          bottom: 20,
                          onSelect: changeSelectValue,
                          option: docTypeList.map((e) => e.name).toList(),
                          name: 'document_type_id',
                          label: 'Document Type',
                        ),
                        AppTextField(
                          name: 'title',
                          label: "Title",
                          bottom: 20,
                          error:
                              _formKey.currentState?.fields['title']?.errorText,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Title is required')
                          ]),
                        ),
                        const AppTextField(
                          name: 'notes',
                          label: "Notes",
                          bottom: 20,
                        ),
                        _image == null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Image.asset(
                                  'assets/images/select-image.png',
                                  width: 300,
                                ),
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.fitWidth,
                              )
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          ImagePick.pickerImage(context, (File image) {
                            setState(() {
                              _image = image;
                            });
                          });
                        },
                        icon: const Icon(Icons.wallpaper_outlined),
                        label: Text(_image == null
                            ? 'SELECT DOCUMENT'
                            : 'RESELECT DOCUMENT')),
                    const SizedBox(height: 24),
                    _image == null
                        ? const SizedBox()
                        : ElevatedButton.icon(
                            onPressed: loading
                                ? null
                                : () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      var body = {
                                        ..._formKey.currentState?.value ?? {}
                                      };
                                      var formatBody = body
                                          .map<String, String>((key, value) {
                                        if (key == 'document_type') {
                                          var dt = docTypeList.firstWhere(
                                              (element) =>
                                                  element.name == value);
                                          return MapEntry(
                                              key, dt.id.toString());
                                        }
                                        return MapEntry(key, value.toString());
                                      });
                                      if (_image != null) {
                                        formatBody['file'] =
                                            (_image as File).path;
                                      }
                                      var http = HttpRequest();
                                      setState(() {
                                        loading = true;
                                      });
                                      http.uploadDoc(formatBody).then((value) {
                                        setState(() {
                                          loading = false;
                                        });
                                        if (value.success == true) {
                                          SnackBarMessage.successSnackbar(
                                              context,
                                              "File Upload SuccessFully");
                                          Navigator.pop(context);
                                        } else {
                                          SnackBarMessage.errorSnackbar(
                                              context, value.message);
                                        }
                                      });
                                    }
                                  },
                            icon: const Icon(Icons.cloud_upload_outlined),
                            label: const Text('UPLOAD DOCUMENT')),
                  ])),
            ]),
          ),
        ));
  }
}
