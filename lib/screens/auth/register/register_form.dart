import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/screens/auth/register/form_steps.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/others/back_layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/http.dart';
import '../../../widgets/messages/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const route = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  bool loading = false; // ✅ stateful loading

  String? fieldsErrors(String name) {
    if (_formKey.currentState == null) return null;
    return _formKey.currentState!.fields[name]?.errorText;
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 365;

    final List<Widget> steps = <Widget>[
      Step1(fieldsError: fieldsErrors),
      Step2(fieldsError: fieldsErrors),
    ];

    return BackLayout(
      totalTabs: 2,
      currentTabs: _currentStep,
      text: 'Register',
      page: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: FormBuilder(
            key: _formKey,
            onChanged: () => _formKey.currentState!.save(),
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: {
              'first_name': '',
              'last_name': '',
              'phone': '',
              'email': '',
              'ssn_last_4': '',
              'dob': DateTime.now(),
              'bank_routing_number': '',
              'bank_account_number': '',
              'industry': '',
              'business_url': '',
              'agree': false,
            },
            skipDisabled: true,
            child: Column(
              children: [
                steps[_currentStep],
                const SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: smallDevice ? 40 : 0),
                  child: ElevatedButton(
                    onPressed: _currentStep == 1 && loading
                        ? null
                        : () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_currentStep == 0) {
                          setState(() {
                            _currentStep++;
                          });
                        } else {
                          setState(() => loading = true);

                          var http = HttpRequest();
                          var body = {
                            ..._formKey.currentState?.value ?? {}
                          };

                          var formatBody = body.map<String, String>(
                                (key, value) =>
                                MapEntry(key, value.toString()),
                          );

                          final dob = _formKey.currentState?.value['dob']
                          as DateTime?;
                          if (dob != null) {
                            formatBody['dob_day'] = dob.day.toString();
                            formatBody['dob_month'] =
                                dob.month.toString();
                            formatBody['dob_year'] = dob.year.toString();
                          }

                          http.stripRegister(formatBody).then(
                                (value) async {
                              setState(() => loading = false);

                              if (value.success == true) {
                                SnackBarMessage.successSnackbar(
                                  context,
                                  "Stripe Account Registered successfully",
                                );
                                await launchUrl(
                                  Uri.parse(value.data['data']
                                  ['onboardingLink']),
                                );
                                Navigator.pop(context);
                              } else {
                                SnackBarMessage.errorSnackbar(
                                    context, value.message);
                              }
                            },
                          );
                        }
                      } else {
                        setState(() {});
                      }
                    },
                    child: loading
                        ? CircularProgressIndicator(
                      color: AppColorScheme().black0,
                    )
                        : Text(_currentStep == 1 ? 'Finish' : 'Next'),
                  ),
                ),
                SizedBox(height: _currentStep == 0 ? 0 : 24),
                if (_currentStep == 1)
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: smallDevice ? 40 : 0),
                    child: TextButton(
                      child: const Text('Back'),
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
