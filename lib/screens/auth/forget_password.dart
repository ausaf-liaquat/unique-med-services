import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/screens/auth/verification.dart';
import 'package:ums_staff/shared/theme/color.dart';

import '../../core/http.dart';
import '../../widgets/messages/snackBar.dart';
import '../../widgets/inputs/text_field.dart';
import '../other/support.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const route = '/forget-password';
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
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
                          'email': '',
                        },
                        skipDisabled: true,
                        child: Column(
                          children: [
                            Center(
                              heightFactor: 2,
                              child: Image.asset('assets/images/logo.png',
                                  width: 150),
                            ),
                            AppTextField(
                              error: _formKey
                                  .currentState?.fields['email']!.errorText,
                              bottom: 48,
                              helpText:
                                  'Enter your email to change your password',
                              type: TextInputType.emailAddress,
                              name: 'email',
                              label: 'Username or Email',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Email is required'),
                              ]),
                            ),
                            ElevatedButton(
                              child: const Text('Send Code'),
                              onPressed: () {
                                var api = HttpRequest();
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  api.forgetPassword(_formKey.currentState?.value ?? {}).then((value){
                                    if( value.success ){
                                      // Navigator.pushNamed(
                                      //     context, VerificationScreen.route);

                                    }else{
                                      SnackBarMessage.errorSnackbar(
                                          context, value.message);
                                    }
                                  });
                                } else {
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )))),
          ),
          Container(
            width: 270,
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 24.0, top: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Did you unable to change your password ',
                style: TextStyle(
                    color: AppColorScheme().black90,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, SupportScreen.route);
                        },
                      text: 'Did you Need Help?',
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
