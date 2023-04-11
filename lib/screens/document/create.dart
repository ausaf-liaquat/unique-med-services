import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/shared/theme/color.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/text_field.dart';

class CreateDocumentScreen extends StatefulWidget {
  const CreateDocumentScreen({super.key});
  static const route = 'document/upload';

  @override
  State<CreateDocumentScreen> createState() => _CreateDocumentScreenState();
}

class _CreateDocumentScreenState extends State<CreateDocumentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String passwordError = '';
  String emailError = '';
  @override
  void initState() {
    super.initState();
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
                      'document_type': '',
                      'expire_date': '',
                    },
                    skipDisabled: true,
                    child: Column(
                      children: [
                        AppTextField(
                          error: _formKey
                              .currentState?.fields['document_type']!.errorText,
                          bottom: 16,
                          type: TextInputType.emailAddress,
                          name: 'document_type',
                          label: 'Document Type',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Document type is mendatory'),
                          ]),
                        ),
                        AppTextField(
                          error: _formKey
                              .currentState?.fields['expire_date']!.errorText,
                          bottom: 40,
                          type: TextInputType.datetime,
                          name: 'expire_date',
                          label: 'Expiration Date',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Expiration date is mendatory'),
                          ]),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // error funtion
                      } else {
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.wallpaper_outlined),
                    label: const Text('UPLOAD IMAGE')),
              ),
            ]),
          ),
        ));
  }
}
