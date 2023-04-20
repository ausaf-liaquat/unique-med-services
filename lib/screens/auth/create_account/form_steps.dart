import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../shared/theme/color.dart';
import '../../../widgets/common/group_check_box.dart';
import '../../../widgets/common/group_radio_box.dart';
import '../../../widgets/common/select_field.dart';
import '../../../widgets/common/text_field.dart';
import '../../../widgets/dataDisplay/typography.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
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
            text: "First, we just need some basic information.",
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
          error: fieldsError('phone_number'),
          bottom: 16,
          type: TextInputType.phone,
          name: 'phone_number',
          label: 'Phone Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Phone number is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('code'),
          bottom: 16,
          type: TextInputType.number,
          name: 'code',
          label: 'Zip Code',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Zip code is required'),
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
          ]),
        ),
        AppTextField(
          error: fieldsError('password'),
          bottom: 16,
          type: TextInputType.visiblePassword,
          name: 'password',
          label: 'Password',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Password is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('referred'),
          bottom: 16,
          type: TextInputType.name,
          name: 'referred',
          label: 'Referred ',
          helpText:
              'Both will get \$100 bonus after they complete first shift!',
        ),
        AppSelectField(
          error: fieldsError('qualification_type'),
          title: 'Select the qualification type?',
          bottom: 16,
          onSelect: onSelect,
          option: const ['CVS'],
          name: 'qualification_type',
          label: 'Qualification Type',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Qualification type is required'),
          ]),
        ),
      ],
    );
  }
}

class Step2 extends StatelessWidget {
  const Step2({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  void resumePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      onSelect('resume', result.files.single.path ?? '');
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTypography(
          text: 'What types of shifts are you interested in?',
          size: 20,
          color: AppColorScheme().black80,
        ),
        const SizedBox(height: 16),
        AppGroupCheckBox(
            name: 'avalabilty',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1,
                  errorText: 'Atleast select one option'),
            ]),
            options: const [
              'Day Shifts',
              'Evening Shifts',
              'Overnight Shifts',
              'Weekend Shifts',
              'Weekday Shifts'
            ]),
        const SizedBox(height: 32),
        AppTypography(
          text: 'Please select your amount of licensed work experience below.',
          size: 20,
          color: AppColorScheme().black80,
        ),
        const SizedBox(height: 16),
        AppGroupRadioBox(
            name: 'experience',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(1,
                  errorText: 'Atleast select one option'),
            ]),
            options: const ['0 - 3 months', '4 - 6 months', '6+ months']),
        const SizedBox(height: 40),
        InkWell(
          onTap: resumePick,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                color: AppColorScheme().black0,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            child: Center(
                child: SizedBox(
              width: 140,
              child: AppTypography(
                align: TextAlign.center,
                text: 'Upload Resume in PDF Formet',
                size: 16,
                height: 1.4,
                color: AppColorScheme().black60,
              ),
            )),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
