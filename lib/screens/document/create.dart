import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/shared/theme/color.dart';
import '../../shared/utils/initial_data.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/date_field.dart';
import '../../widgets/common/select_field.dart';

class CreateDocumentScreen extends StatefulWidget {
  const CreateDocumentScreen({super.key});
  static const route = 'document/upload';

  @override
  State<CreateDocumentScreen> createState() => _CreateDocumentScreenState();
}

class _CreateDocumentScreenState extends State<CreateDocumentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

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
                    initialValue: {
                      'document_type': AppInitialData().documentTypes[0],
                      'expire_date': DateTime.now(),
                    },
                    skipDisabled: true,
                    child: Column(
                      children: [
                        AppSelectField(
                          error: _formKey
                              .currentState?.fields['document_type']!.errorText,
                          bottom: 20,
                          onSelect: changeSelectValue,
                          option: AppInitialData().documentTypes,
                          name: 'document_type',
                          label: 'Document Type',
                        ),
                        AppDateField(
                          error: _formKey
                              .currentState?.fields['expire_date']!.errorText,
                          bottom: 40,
                          type: TextInputType.datetime,
                          name: 'expire_date',
                          label: 'Expiration Date',
                        ),
                        Image.asset(
                          'assets/images/select-image.png',
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.wallpaper_outlined),
                    label: const Text('UPLOAD IMAGE')),
              ),
            ]),
          ),
        ));
  }
}
