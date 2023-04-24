import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';

import '../../widgets/common/Link.dart';
import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/messages/snackBar.dart';
import 'create_account/create_account_form.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          'password': '',
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
                                  .currentState?.fields['email']!.errorText,
                              bottom: 16,
                              type: TextInputType.emailAddress,
                              name: 'email',
                              label: 'Username or Email',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Email is required'),
                                FormBuilderValidators.email(
                                    errorText: 'Invalid email address')
                              ]),
                            ),
                            AppTextField(
                              error: _formKey
                                  .currentState?.fields['password']!.errorText,
                              bottom: 40,
                              type: TextInputType.visiblePassword,
                              name: 'password',
                              label: 'Password',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Password is required'),
                              ]),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() {
                                    var api = HttpRequest();
                                    api
                                        .login(_formKey.currentState?.value)
                                        .then((value) {
                                      if (!value.success) {
                                        SnackBarMessage.errorSnackbar(
                                            context, value.message);
                                      }else{
                                        Navigator.pushNamed(
                                            context, LandingScreen.route);
                                      }
                                    });
                                  });

                                } else {
                                  setState(() {});
                                }
                              },
                              child: const Text('LOGIN'),
                            ),
                            const SizedBox(height: 24),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppLink(
                                    path: ForgetPasswordScreen.route,
                                    child: AppTypography(
                                      text: 'Forget Password?',
                                      size: 14,
                                      spacing: 0.1,
                                      color: AppColorScheme().black90,
                                    ),
                                  ),
                                  AppLink(
                                      path: CreateAccountScreen.route,
                                      child: AppTypography(
                                        text: 'Apply',
                                        size: 14,
                                        spacing: 0.1,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ))
                                ])
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
