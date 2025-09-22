import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/shared/utils/web_redirect.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/dataDisplay/typography.dart';
import '../../widgets/messages/snack_bar.dart';
import '../../widgets/others/link.dart';
import '../landing.dart';
import 'create_account/create_account_form.dart';
import 'forget_password.dart';
import 'verification.dart'; // Make sure to import verification screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    var http = HttpRequest();
    var token = http.checkToken();
    if (token != null && token != '') {
      Navigator.pushNamed(context, LandingScreen.route);
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Some thing went Wrong!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                                  error: _formKey.currentState
                                      ?.fields['password']!.errorText,
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
                                  onPressed: loading
                                      ? () {}
                                      : () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      setState(() {
                                        loading = true;
                                      });
                                      var api = HttpRequest();
                                      api.login(_formKey.currentState?.value).then((value) {
                                        setState(() {
                                          loading = false;
                                        });

                                        // DEBUG: Print the entire response
                                        print('=== LOGIN RESPONSE DEBUG ===');
                                        print('Success: ${value.success}');
                                        print('Message: ${value.message}');
                                        print('Full data: ${value.data}');

                                        if (value.data != null) {
                                          print('Nested data: ${value.data['data']}');
                                          print('AccountStatus: ${value.data['data']?['accountStatus']}'); // FIXED
                                          print('Token: ${value.data['data']?['token']}'); // FIXED
                                        }
                                        print('==========================');

                                        if (!value.success) {
                                          SnackBarMessage.errorSnackbar(context, value.message);
                                        } else {
                                          // CORRECTED: Access the nested data field
                                          final accountStatus = value.data?['data']?['accountStatus'] ?? 'verified'; // FIXED
                                          final email = _formKey.currentState?.value['email'] ?? '';
                                          final token = value.data?['data']?['token'] ?? ''; // FIXED

                                          print('Corrected accountStatus: $accountStatus'); // Should show "unverified"
                                          print('Corrected token: $token');

                                          if (accountStatus == 'unverified') {
                                            // Save the token for verification
                                            if (token.isNotEmpty) {
                                              api.saveToken(token);
                                            }

                                            // Redirect to verification screen
                                            Navigator.pushReplacementNamed(
                                              context,
                                              VerificationScreen.route,
                                              arguments: {
                                                'email': email,
                                                'register': true,
                                              },
                                            );
                                          } else {
                                            // Account is verified, save token and go to landing
                                            if (token.isNotEmpty) {
                                              api.saveToken(token);
                                            }
                                            Navigator.pushReplacementNamed(context, LandingScreen.route);
                                          }
                                        }
                                      }).catchError((error) {
                                        setState(() {
                                          loading = false;
                                        });
                                        SnackBarMessage.errorSnackbar(context, 'Login failed. Please try again.');
                                      });
                                    } else {
                                      setState(() {});
                                    }
                                  },
                                  child: loading
                                      ? CircularProgressIndicator(
                                    color: AppColorScheme().black0,
                                  )
                                      : const Text('LOGIN'),
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                WebRedirect().privacyPolicy(context);
                              });
                            },
                          text: 'Privacy policy',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary)),
                      const TextSpan(text: ' and '),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                WebRedirect().termsAndConditions(context);
                              });
                            },
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
        ));
  }
}