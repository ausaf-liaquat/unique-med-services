import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/other/w9_form/form_steps.dart';

import '../../../shared/utils/initial_data.dart';
import '../../../widgets/messages/snack_bar.dart';
import '../../../widgets/others/back_layout.dart';

class W9FormScreen extends StatefulWidget {
  const W9FormScreen({super.key});
  static const route = '/w9-form';

  @override
  State<W9FormScreen> createState() => _W9FormScreenState();
}

class _W9FormScreenState extends State<W9FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;

  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  String? fieldsErrors(String name) {
    if (_formKey.currentState!.fields[name] == null) {
      return null;
    } else {
      return _formKey.currentState!.fields[name]!.errorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 365;
    bool loading = false;
    final List<Widget> steps = <Widget>[
      const Step1(),
      Step2(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step3(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step4(onSelect: changeSelectValue, fieldsError: fieldsErrors),
    ];

    return BackLayout(
        totalTabs: 4,
        currentTabs: _currentStep,
        text: 'Electronic W-9',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: {
                    // second step
                    'name': '',
                    'business_name': '',
                    'federal_tax_classification':
                        AppInitialData().federalTaxClassification[0],
                    'classification_detail': '',
                    'exempt_payee_code': '',
                    'fatca_code': '',
                    'account_number': '',
                    'social_security_number': '',
                    'ei_number': '',
                    // 'date': DateTime.now(),
                    // third step
                    'requester_first_name': '',
                    'requester_last_name': '',
                    'requester_address': '',
                    'requester_city': '',
                    'requester_state': '',
                    'requester_zip_code': '',
                    // fourth step
                    'agree': false,
                    'address': '',
                    'city': '',
                    'state': '',
                    'zip_code': ''
                  },
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      steps[_currentStep],
                      const SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallDevice ? 40 : 0),
                        child: ElevatedButton(
                          onPressed: _currentStep == 3 && loading ? null: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_currentStep == 3) {
                                setState(() {
                                  loading = true;
                                });
                                var http = HttpRequest();
                                var body = {..._formKey.currentState?.value ?? {}};
                                var formatBody = body.map<String, String>((key, value) => MapEntry(key, value.toString()));
                                http.w9(formatBody).then((value){
                                  setState(() {
                                    loading = false;
                                  });
                                  if( value.success == true ){
                                    SnackBarMessage.successSnackbar(context, "Electronic W-9 save successfully");
                                    Navigator.pop(context);
                                  }else{
                                    SnackBarMessage
                                        .errorSnackbar(
                                        context, value.message);
                                  }
                                });
                              } else {
                                setState(() {
                                  _currentStep = _currentStep + 1;
                                });
                              }
                            } else {
                              setState(() {});
                            }
                          },
                          child: loading ? const  CircularProgressIndicator(): Text(_currentStep == 5 ? 'Finish' : 'Next'),
                        ),
                      ),
                      SizedBox(height: _currentStep == 0 ? 0 : 24),
                      _currentStep == 0
                          ? const SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: smallDevice ? 40 : 0),
                              child: TextButton(
                                child: const Text('Back'),
                                onPressed: () {
                                  setState(() {
                                    _currentStep = _currentStep - 1;
                                  });
                                },
                              ),
                         )
                    ],
                  ))),
        ));
  }
}
