import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/screens/auth/verification.dart';
import 'package:ums_staff/shared/theme/color.dart';

import '../../core/http.dart';
import '../../widgets/messages/snack_bar.dart';
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
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState?.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {'email': ''},
                  skipDisabled: true,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Modern Header Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Reset Your Password',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColorScheme().black90,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter your email to receive a verification code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColorScheme().black60,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Use FormBuilderTextField instead of TextFormField
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: FormBuilderTextField(
                          name: 'email', // This is crucial - name must match
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: AppColorScheme().black60,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColorScheme().black60,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColorScheme().black30,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColorScheme().black30,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            hintText: 'Enter your email address',
                            hintStyle: TextStyle(
                              color: AppColorScheme().black40,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                      ),

                      // Send Code Button with Icon
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: _loading
                              ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColorScheme().black0,
                              strokeWidth: 2,
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_outlined,
                                color: AppColorScheme().black0,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Send Verification Code',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorScheme().black0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Cancel Button with Icon
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: AppColorScheme().black60,
                            size: 20,
                          ),
                          label: Text(
                            'Back to Login',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColorScheme().black60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Modern Help Section
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Divider(
                  color: AppColorScheme().black20,
                  height: 1,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 18,
                        color: AppColorScheme().black60,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Need assistance? ',
                            style: TextStyle(
                              color: AppColorScheme().black60,
                              fontSize: 13,
                              height: 1.4,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, SupportScreen.route);
                                  },
                                text: 'Contact Support',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    // Save the form first to ensure all values are captured
    _formKey.currentState?.save();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _loading = true;
      });

      try {
        final formData = _formKey.currentState?.value;
        final email = formData?['email']?.toString() ?? '';

        print("Form data: $formData");
        print("Email: $email");

        final api = HttpRequest();
        final value = await api.forgetPassword({'email': email});

        setState(() {
          _loading = false;
        });

        print("API response: $value");

        if (value.success) {
          if (mounted) {
            Navigator.pushNamed(
              context,
              VerificationScreen.route,
              arguments: {
                "email": email,
              },
            );
          }
        } else {
          if (mounted) {
            SnackBarMessage.errorSnackbar(context, value.message);
          }
        }
      } catch (error) {
        setState(() {
          _loading = false;
        });

        if (mounted) {
          SnackBarMessage.errorSnackbar(
            context,
            'An error occurred. Please try again.',
          );
        }
      }
    } else {
      setState(() {});
    }
  }
}