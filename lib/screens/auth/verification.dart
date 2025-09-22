import 'dart:async';
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
  bool _loading = false;
  bool _resendLoading = false;
  int _countdown = 0;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = 60;
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resendCode() async {
    if (_countdown > 0) return;

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var email = arguments['email'] ?? '';
    var register = arguments['register'] ?? false;

    if (email.isEmpty) {
      SnackBarMessage.errorSnackbar(context, 'Email not found');
      return;
    }

    setState(() {
      _resendLoading = true;
    });

    try {
      var http = HttpRequest();

      if (register) {
        final response = await http.resendVerificationCode({'email': email});
        if (response.success) {
          SnackBarMessage.successSnackbar(context, 'Verification code sent successfully!');
          _startCountdown();
        } else {
          SnackBarMessage.errorSnackbar(context, response.message ?? 'Failed to send code');
        }
      } else {
        // // For password reset, use forgotPassword instead
        // final response = await http.forgotPassword({'email': email});
        // if (response.success) {
        //   SnackBarMessage.successSnackbar(context, 'Verification code sent successfully!');
        //   _startCountdown();
        // } else {
        //   SnackBarMessage.errorSnackbar(context, response.message ?? 'Failed to send code');
        // }
      }
    } catch (e) {
      SnackBarMessage.errorSnackbar(context, 'An error occurred. Please try again.');
    } finally {
      setState(() {
        _resendLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments);
    var register = arguments['register'] ?? false;
    var email = arguments['email'] ?? '';

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
                              error: _formKey.currentState?.fields['otp']!.errorText,
                              bottom: 48,
                              helpText: 'Enter 4 digit code which has been send to email',
                              type: TextInputType.number,
                              name: 'otp',
                              label: 'Verification Code',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Verification code is required'),
                              ]),
                            ),
                            ElevatedButton(
                              onPressed: _loading ? null : () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  setState(() {
                                    _loading = true;
                                  });

                                  try {
                                    var http = HttpRequest();
                                    var formatBody = _formKey.currentState?.value
                                        .map<String, String>((key, value) => MapEntry(key, value.toString()));

                                    if (register) {

                                      final value = await http.regVerify(formatBody);
                                      setState(() {
                                        _loading = false;
                                      });
                                      if (value.success == true) {
                                        Navigator.pushReplacementNamed(context, LandingScreen.route);
                                      } else {
                                        SnackBarMessage.errorSnackbar(context, value.message ?? 'Verification failed');
                                      }
                                    } else {
                                      print('----------------------- otp');
                                    var data = {
                                      'email': email.toString(),
                                      'code': formatBody!['otp'].toString() ?? ''
                                    };

                                    // Use verify() instead of regVerify() for password reset
                                    final value = await http.verify(data);
                                    setState(() {
                                      _loading = false;
                                    });
                                    if (value.success == true) {
                                      Navigator.pushReplacementNamed(
                                          context,
                                          ChangePasswordScreen.route,
                                          arguments: {"email": email});
                                    } else {
                                      SnackBarMessage.errorSnackbar(context, value.message ?? 'Verification failed');
                                    }
                                    }
                                  } catch (e, stack) {
                                    setState(() {
                                      _loading = false;
                                    });
                                    print('=== VERIFICATION ERROR ===');
                                    print(e);
                                    print(stack);
                                    SnackBarMessage.errorSnackbar(context, 'An error occurred. Please try again.');
                                  }
                                }
                              },
                              child: _loading
                                  ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColorScheme().black0,
                                ),
                              )
                                  : const Text('VERIFY'),
                            ),
                            const SizedBox(height: 24),
                          ],
                        )))),
          ),
          Container(
            width: 250,
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 24.0, top: 16.0),
            child: _resendLoading
                ? Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
                : GestureDetector(
              onTap: _countdown > 0 ? null : _resendCode,
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
                      text: _countdown > 0
                          ? 'Resend in $_countdown'
                          : 'Resend Code Again?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _countdown > 0
                            ? AppColorScheme().black60
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}