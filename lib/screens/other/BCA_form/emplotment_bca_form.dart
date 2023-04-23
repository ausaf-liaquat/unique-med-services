import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../widgets/others/back_layout.dart';
import '../BCA_form/form_steps.dart';

class EmplotmentFormScreen extends StatefulWidget {
  const EmplotmentFormScreen({super.key});
  static const route = '/emplotment-BCA';

  @override
  State<EmplotmentFormScreen> createState() => _EmplotmentFormScreenState();
}

class _EmplotmentFormScreenState extends State<EmplotmentFormScreen> {
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
    final List<Widget> steps = <Widget>[
      Step1(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step2(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step3(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step4(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step5(onSelect: changeSelectValue, fieldsError: fieldsErrors),
      Step6(onSelect: changeSelectValue, fieldsError: fieldsErrors),
    ];

    return BackLayout(
        totalTabs: 6,
        currentTabs: _currentStep,
        text: 'Emplotment BCA',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: {
                    // first step
                    'first_name': '',
                    'last_name': '',
                    'middle_initial': '',
                    'title': '',
                    'social_security_number': '',
                    'date_of_birth': DateTime.now(),
                    'email': '',
                    'maiden': '',
                    'date_last_used': '',
                    // second step
                    'current_address': '',
                    'current_state': '',
                    'current_city': '',
                    'current_code': '',
                    // third step
                    'previous_address': '',
                    'previous_state': '',
                    'previous_city': '',
                    'previous_code': '',
                    'date_form': DateTime.now(),
                    'date_to': DateTime.now(),
                    // forth step
                    'q1_date': DateTime.now(),
                    'q1_state': '',
                    'q1_city': '',
                    'q1_note': 'Enter notes...',
                    // fifth step
                    'q2_date': DateTime.now(),
                    'q2_state': '',
                    'q2_city': '',
                    'q2_note': 'Enter notes...',
                    // sixth step
                    'agree': false,
                    'print_name': '',
                    'q3_court_name': '',
                    'q3_date': DateTime.now(),
                    'q3_state': '',
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
                          child: Text(_currentStep == 5 ? 'Finish' : 'Next'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_currentStep == 5) {
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
