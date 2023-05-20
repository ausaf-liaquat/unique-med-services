import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/screens/landing.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';

import '../../core/http.dart';
import '../../widgets/messages/snack_bar.dart';
import 'change_password.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});
  static const route = '/verification';
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var register = arguments['register'] ?? false;
    var email = arguments['email'] ?? '';
    var loading = false;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: FormBuilder(
                        key: _formKey,
                        onChanged: () {
                          _formKey.currentState!.save();
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        initialValue: const {
                          'otp': '',
                        },
                        skipDisabled: true,
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 300,
                              child: Center(
                                child: Image.asset('assets/images/logo.png',
                                    width: 150),
                              ),
                            ),
                            AppTextField(
                              error: _formKey
                                  .currentState?.fields['otp']!.errorText,
                              bottom: 48,
                              helpText:
                                  'Enter 6 digit code which has been send to email',
                              type: TextInputType.number,
                              name: 'otp',
                              label: 'Verification Code',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Verification code is required'),
                              ]),
                            ),
                            ElevatedButton(
                              onPressed: loading
                                  ? () {}
                                  : () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        setState(() {
                                          loading = true;
                                        });
                                        var http = HttpRequest();
                                        var formatBody = _formKey
                                            .currentState?.value
                                            .map<String, String>((key, value) =>
                                                MapEntry(
                                                    key, value.toString()));
                                        if (register) {
                                          print(formatBody);
                                          http
                                              .regVerify(formatBody)
                                              .then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                            if (value.success == true) {
                                              Navigator.pushReplacementNamed(
                                                  context, LandingScreen.route);
                                            } else {
                                              SnackBarMessage.errorSnackbar(
                                                  context, value.message);
                                            }
                                          });
                                        } else {
                                          var data = {
                                            'email': email.toString(),
                                            'code':
                                                formatBody!['otp'].toString() ??
                                                    ''
                                          };
                                          http.verify(data).then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                            if (value.success == true) {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  ChangePasswordScreen.route,
                                                  arguments: {"email": email});
                                            } else {
                                              SnackBarMessage.errorSnackbar(
                                                  context, value.message);
                                            }
                                          });
                                        }
                                      } else {
                                        setState(() {});
                                      }
                                    },
                              child: loading
                                  ? CircularProgressIndicator(
                                      color: AppColorScheme().black0,
                                    )
                                  : const Text('Verify'),
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                              child: const Text('Back'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )))),
          ),
          Container(
            width: 250,
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 24.0, top: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Did you receive verification code ',
                style: TextStyle(
                    color: AppColorScheme().black90,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Resend Code Again?',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
