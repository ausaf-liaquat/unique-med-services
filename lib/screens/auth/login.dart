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
import 'verification.dart';

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
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColorScheme().black90,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColorScheme().black60,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
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
                          const SizedBox(height: 32),

                          // Email Field
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: AppTextField(
                              error: _formKey.currentState?.fields['email']!.errorText,
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
                          ),

                          // Password Field
                          Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: AppTextField(
                              error: _formKey.currentState?.fields['password']!.errorText,
                              type: TextInputType.visiblePassword,
                              name: 'password',
                              label: 'Password',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Password is required'),
                              ]),
                            ),
                          ),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: loading
                                  ? () {}
                                  : () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  setState(() {
                                    loading = true;
                                  });
                                  var api = HttpRequest();
                                  api.login(_formKey.currentState?.value).then((value) async {
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
                                      print('AccountStatus: ${value.data['data']?['accountStatus']}');
                                      print('Token: ${value.data['data']?['token']}');
                                    }
                                    print('==========================');

                                    if (!value.success) {
                                      SnackBarMessage.errorSnackbar(context, value.message);
                                    } else {
                                      final accountStatus = value.data?['data']?['accountStatus'] ?? 'verified';
                                      final email = _formKey.currentState?.value['email'] ?? '';
                                      final token = value.data?['data']?['token'] ?? '';

                                      print('Corrected accountStatus: $accountStatus');
                                      print('Corrected token: $token');

                                      if (accountStatus == 'unverified') {
                                        // Save the token for verification
                                        if (token.isNotEmpty) {
                                          api.saveToken(token);
                                        }

                                        try {
                                          var http = HttpRequest();
                                          final response = await http.resendVerificationCode({'email': email});
                                          if (response.success) {
                                            print('Verification code resent to $email');
                                            SnackBarMessage.successSnackbar(context, 'Verification code sent!');
                                          } else {
                                            print('Failed to resend code: ${response.message}');
                                            SnackBarMessage.errorSnackbar(context, 'Failed to send code: ${response.message}');
                                          }
                                        } catch (e) {
                                          print('❌ Error resending code: $e');
                                          SnackBarMessage.errorSnackbar(context, 'Error sending verification code');
                                        }

                                        // Redirect to verification screen AFTER the code is sent
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: loading
                                  ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColorScheme().black0,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorScheme().black0,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Links Section
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColorScheme().black20,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, ForgetPasswordScreen.route);
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColorScheme().black90,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, CreateAccountScreen.route);
                                  },
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.error,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Footer Section
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Divider(
                      color: AppColorScheme().black20,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By using the app, you agree to our ',
                        style: TextStyle(
                          color: AppColorScheme().black60,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebRedirect().privacyPolicy(context);
                              },
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WebRedirect().termsAndConditions(context);
                              },
                            text: 'Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}