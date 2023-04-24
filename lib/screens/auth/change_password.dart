import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';

import 'login.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const route = '/change-password';
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
                          'password': '',
                          'conform_password': '',
                        },
                        skipDisabled: true,
                        child: Column(
                          children: [
                            Center(
                              heightFactor: 1.9,
                              child: Image.asset('assets/images/logo.png',
                                  width: 150),
                            ),
                            AppTextField(
                              error: _formKey
                                  .currentState?.fields['password']!.errorText,
                              bottom: 16,
                              type: TextInputType.visiblePassword,
                              name: 'password',
                              label: 'New Password',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'New password is required'),
                              ]),
                            ),
                            AppTextField(
                              error: _formKey.currentState
                                  ?.fields['conform_password']!.errorText,
                              bottom: 40,
                              type: TextInputType.visiblePassword,
                              name: 'conform_password',
                              label: 'Conform Password',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.equal(
                                    _formKey.currentState?.value['password'] ??
                                        '',
                                    errorText:
                                        'Conform password must be same as password'),
                              ]),
                            ),
                            ElevatedButton(
                              child: const Text('Change Password'),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  Navigator.pushNamed(
                                      context, LoginScreen.route);
                                } else {
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pushNamed(context, LoginScreen.route);
                              },
                            ),
                          ],
                        )))),
          ),
          Container(
            width: 260,
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 24.0, top: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By using the app, you agree to our ',
                style: TextStyle(
                    color: AppColorScheme().black90,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Privacy policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                  const TextSpan(text: ' and '),
                  TextSpan(
                      text: 'Terms of Service.',
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
