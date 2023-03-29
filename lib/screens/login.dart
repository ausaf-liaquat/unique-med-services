import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/common/text_field.dart';

import '../widgets/common/typography.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            heightFactor: 1.9,
            child: Image.asset('assets/images/logo.png', width: 150),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: FormBuilder(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState!.save();
                      debugPrint(_formKey.currentState!.value.toString());
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: const {
                      'email': '',
                      'password': '',
                    },
                    skipDisabled: true,
                    child: Column(
                      children: [
                        AppTextField(
                          error:
                              _formKey.currentState?.fields['email']!.errorText,
                          bottom: 16,
                          name: 'email',
                          label: 'Username or Email',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Email is mendatory'),
                          ]),
                        ),
                        AppTextField(
                          error: _formKey
                              .currentState?.fields['password']!.errorText,
                          bottom: 40,
                          name: 'password',
                          label: 'Password',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Password is mendatory'),
                          ]),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              // error funtion
                            } else {
                              // sucess funtion
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTypography(
                                text: 'Forget Password?',
                                size: 14,
                                spacing: 0.1,
                                color: AppColorScheme().black90,
                              ),
                              AppTypography(
                                text: 'Apply',
                                size: 14,
                                spacing: 0.1,
                                color: Theme.of(context).colorScheme.error,
                              )
                            ])
                      ],
                    ))),
          ),
          Container(
            width: 260,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0),
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
