import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../shared/theme/color.dart';
import '../../../shared/utils/web_redirect.dart';
import '../../../widgets/card/upload_file.dart';
import '../../../widgets/inputs/check_box.dart';
import '../../../widgets/inputs/date_field.dart';
import '../../../widgets/inputs/group_check_box.dart';
import '../../../widgets/inputs/group_radio_box.dart';
import '../../../widgets/inputs/select_field.dart';
import '../../../widgets/inputs/text_field.dart';
import '../../../widgets/dataDisplay/typography.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key, required this.fieldsError});
  final String? Function(String) fieldsError;

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
            text:
                "For registration first, we just need some basic information.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 16),
        AppTextField(
          error: fieldsError('first_name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'first_name',
          label: 'First Name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'First name is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('last_name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'last_name',
          label: 'Last Name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Last name is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('phone'),
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
          error: fieldsError('email'),
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
          error: fieldsError('ssn_last_4'),
          bottom: 16,
          type: TextInputType.number,
          name: 'ssn_last_4',
          label: 'SSN',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Email is required'),
          ]),
        ),
        AppDateField(
          error: fieldsError('dob'),
          bottom: 16,
          name: 'dob',
          label: 'Date Of Birth',
        ),
      ],
    );
    ;
  }
}

class Step2 extends StatefulWidget {
  const Step2({super.key, required this.fieldsError});
  final String? Function(String) fieldsError;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
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
            text:
            "For registration second, we need some bank information.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 16),
        AppTextField(
          error: widget.fieldsError('bank_routing_number'),
          bottom: 16,
          type: TextInputType.number,
          name: 'bank_routing_number',
          label: 'Bank Routing Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Bank routing number is required'),
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('bank_account_number'),
          bottom: 16,
          type: TextInputType.number,
          name: 'bank_account_number',
          label: 'Bank Account Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Bank account number is required'),
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('industry'),
          bottom: 16,
          type: TextInputType.name,
          name: 'industry',
          label: 'Industry',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Industry is required'),
          ]),
        ),
        AppTextField(
          error: widget.fieldsError('business_url'),
          bottom: 16,
          type: TextInputType.url,
          name: 'business_url',
          label: 'Business Website',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Business website is required'),
            FormBuilderValidators.url(errorText: 'Invalid business website')
          ]),
        ),
        const SizedBox(height: 8),
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
