import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/screens/w9_form/form_steps.dart';

import '../../shared/utils/initial_data.dart';
import '../../widgets/common/back_layout.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 365;

    return BackLayout(
        text: 'ELectronic W-9',
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
                    'entity_name': '',
                    'federal_tax_classification':
                        AppInitialData().federalTaxClassification[0],
                    'tax_classification': '',
                    'payee_code': '',
                    'reporting_code': '',
                    'list_account_number': '',
                    'social_security_number': '',
                    'employer_identification_number': '',
                    'date': DateTime.now(),
                    // third step
                    'requester_first_name': '',
                    'requester_last_name': '',
                    'requester_address': '',
                    'requester_city': '',
                    'requester_state': '',
                    'requester_code': '',
                    // fourth step
                    'agree': false,
                    'address': '',
                    'city': '',
                    'state': '',
                    'code': ''
                  },
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormSteps(
                          fieldsError: fieldsErrors,
                          index: _currentStep,
                          onSelect: changeSelectValue),
                      const SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallDevice ? 40 : 0),
                        child: ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_currentStep == 3) {
                                // form complete funtion
                              } else {
                                setState(() {
                                  _currentStep = _currentStep + 1;
                                });
                              }
                            } else {
                              setState(() {});
                            }
                          },
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
