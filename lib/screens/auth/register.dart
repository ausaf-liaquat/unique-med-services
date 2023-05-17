import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/shared/utils/web_redirect.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import 'package:ums_staff/widgets/inputs/check_box.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';
import 'package:ums_staff/widgets/others/back_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const route = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  String? fieldsErrors(String name) {
    if (_formKey.currentState!.fields[name] == null) {
      return null;
    } else {
      return _formKey.currentState!.fields[name]!.errorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackLayout(
      text: 'Register',
      page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'phone': '',
                    'email': '',
                    'name': '',
                    'bussness_website': '',
                    'agree': false
                  },
                  skipDisabled: true,
                  child: Column(
                    children: [
                      RegisterForm(
                        fieldsError: fieldsErrors,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          onPressed: loading
                              ? () {}
                              : () {
                            if (_formKey.currentState?.validate() ??
                                false) {
                            } else {
                              setState(() {});
                            }
                          },
                          child: loading
                              ? CircularProgressIndicator(
                            color: AppColorScheme().black0,
                          )
                              : const Text('Finish'),
                        ),
                      )
                    ],
                  )))),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.fieldsError});
  final String? Function(String) fieldsError;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Hi there!',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        AppTypography(
            text: "For registration, we just need some basic information.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 16),
        AppTextField(
          error: widget.fieldsError('name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'name',
          label: 'Name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Name is required'),
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('email'),
          bottom: 16,
          type: TextInputType.emailAddress,
          name: 'email',
          label: 'Email',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Email is required'),
            FormBuilderValidators.email(errorText: 'Invalid email address')
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('phone'),
          bottom: 16,
          type: TextInputType.phone,
          name: 'phone',
          label: 'Mobile Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Phone number is required')
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('phone'),
          bottom: 16,
          type: TextInputType.phone,
          name: 'phone',
          label: 'Mobile Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Phone number is required'),
            FormBuilderValidators.url(errorText: 'Invalid business website')
          ]),
        ),
        AppCheckBox(
          validator: FormBuilderValidators.equal(
            true,
            errorText: 'You must accept to continue',
          ),
          text: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'I have read and agree to Unique Med Services ',
              style: TextStyle(color: AppColorScheme().black60, fontSize: 14),
              children: <TextSpan>[
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          WebRedirect().privacyPolicy(context);
                        });
                      },
                    text: 'Terms of Service',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary)),
                const TextSpan(text: ' , '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          WebRedirect().privacyPolicy(context);
                        });
                      },
                    text: 'Privacy Policy',
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
                    text: 'SMS Terms of Service',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
          name: 'agree',
        ),
      ],
    );
  }
}
