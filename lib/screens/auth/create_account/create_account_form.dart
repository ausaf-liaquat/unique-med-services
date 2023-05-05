import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/screens/auth/create_account/form_steps.dart';
import 'package:ums_staff/screens/auth/verification.dart';

import '../../../core/http.dart';
import '../../../shared/theme/color.dart';
import '../../../widgets/messages/snack_bar.dart';
import '../../../widgets/others/back_layout.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  static const route = '/create-account';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  dynamic resume;
  bool loading = false;
  int _currentStep = 0;

  void changeSelectValue(String name, dynamic value) {
      _formKey.currentState!.fields[name]!.didChange(value);
  }

  void updateResume(dynamic value) {
    resume = value;
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
      Step2(
          onSelect: changeSelectValue,
          fieldsError: fieldsErrors,
          updateResume: updateResume),
    ];
    return BackLayout(
        totalTabs: 2,
        currentTabs: _currentStep,
        text: 'Apply Clinician',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'first_name': '',
                    'last_name': '',
                    'phone': '',
                    'zip_code': '',
                    'email': '',
                    'password': '',
                    'reffered_by': '',
                    'qualification_type': '',
                    'resume': ''
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
                          onPressed: loading ? (){} : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (_currentStep == 1) {
                                setState(() {
                                  loading = true;
                                });
                                var http = HttpRequest();
                                var body = {..._formKey.currentState?.value ?? {}};
                                var formatBody = body.map<String, String>((key, value) => MapEntry(key, value.toString()));
                                if(resume != null){
                                  formatBody['resume'] = (resume as File).path;
                                }
                                http.register(formatBody).then((value){
                                  setState(() {
                                    loading = false;
                                  });
                                  if( value.success == true ){
                                    Navigator.pushNamed(
                                          context, VerificationScreen.route, arguments: {'register': true});
                                  }else{
                                    SnackBarMessage.errorSnackbar(
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
                          child: loading ? CircularProgressIndicator(
                            color: AppColorScheme().black0,
                          ) : Text(_currentStep == 1 ? 'Finish' : 'Next'),
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
                  )
              )
          ),
        ));
  }
}
