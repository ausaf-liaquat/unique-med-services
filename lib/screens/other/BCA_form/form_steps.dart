import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/widgets/dataDisplay/list_item.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../../shared/theme/color.dart';
import '../../../widgets/inputs/check_box.dart';
import '../../../widgets/inputs/date_field.dart';
import '../../../widgets/inputs/group_radio_box.dart';
import '../../../widgets/inputs/select_field.dart';
import '../../../widgets/inputs/text_field.dart';

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
          text: 'Background Check Info',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "By typing your name below, you are confirming that you have read and are electronically signing this document.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 24),
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
          error: fieldsError('middle_initial'),
          bottom: 16,
          type: TextInputType.name,
          name: 'middle_initial',
          label: 'Middle Initial',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Middle initial is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('title'),
          bottom: 16,
          type: TextInputType.name,
          name: 'title',
          label: 'Title',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Title is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('social_security'),
          bottom: 16,
          type: TextInputType.name,
          name: 'social_security',
          label: 'Social Security Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Social security number is required'),
          ]),
        ),
        AppDateField(
          error: fieldsError('dob'),
          bottom: 16,
          name: 'dob',
          label: 'Date Of Birth',
        ),
        AppTextField(
          error: fieldsError('email'),
          bottom: 16,
          type: TextInputType.name,
          name: 'email',
          label: 'Email',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Email is required'),
            FormBuilderValidators.email(errorText: 'Invalid email address')
          ]),
        ),
        AppTextField(
          error: fieldsError('maiden_name'),
          bottom: 16,
          type: TextInputType.name,
          helpText: '(optional)',
          name: 'maiden_name',
          label: 'Maiden',
        ),
        AppTextField(
          error: fieldsError('last_used'),
          bottom: 16,
          type: TextInputType.name,
          helpText: '(Month/Year) (optional)',
          name: 'last_used',
          label: 'Date Last Used',
        ),
      ],
    );
  }
}

class Step2 extends StatelessWidget {
  const Step2({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Current Address',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "By typing your name below, you are confirming that you have read and are electronically signing this document.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 24),
        AppTextField(
          error: fieldsError('address'),
          bottom: 16,
          type: TextInputType.streetAddress,
          name: 'address',
          label: 'Address',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Address is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('state'),
          bottom: 16,
          type: TextInputType.streetAddress,
          name: 'state',
          label: 'State',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'State is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('city'),
          type: TextInputType.streetAddress,
          bottom: 16,
          name: 'city',
          label: 'City',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'City is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('zip_code'),
          bottom: 16,
          type: TextInputType.number,
          name: 'zip_code',
          label: 'Zip Code',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Zip code is required'),
          ]),
        ),
      ],
    );
  }
}

class Step3 extends StatelessWidget {
  const Step3({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Previous Address',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "By typing your name below, you are confirming that you have read and are electronically signing this document.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 24),
        AppTextField(
          error: fieldsError('address_one'),
          bottom: 16,
          type: TextInputType.streetAddress,
          name: 'address_one',
          label: 'Address',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Address is required'),
          ]),
        ),
        AppTextField(
          type: TextInputType.streetAddress,
          error: fieldsError('state_one'),
          bottom: 16,
          name: 'state_one',
          label: 'State',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'State is required'),
          ]),
        ),
        AppTextField(
          type: TextInputType.streetAddress,
          error: fieldsError('city_one'),
          bottom: 16,
          name: 'city_one',
          label: 'City',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'City is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('zip_one'),
          bottom: 16,
          type: TextInputType.number,
          name: 'zip_one',
          label: 'Zip Code',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Zip code is required'),
          ]),
        ),
        AppDateField(
          error: fieldsError('date_from_one'),
          bottom: 16,
          name: 'date_from_one',
          label: 'Date Lived in Residence: FROM',
        ),
        AppDateField(
          error: fieldsError('date_to_one'),
          bottom: 16,
          name: 'date_to_one',
          label: 'Date Lived in Residence: TO',
        ),
      ],
    );
  }
}

class Step4 extends StatefulWidget {
  Step4(
      {super.key,
      required this.onSelect,
      required this.fieldsError,
      required this.qValue});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;
  String qValue;

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Please Check The Following Question',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        const ListItem(
            text:
                'Within the last seven (7) years have you been convicted of, plead guilty to, or plead “no contest” to a crime that has not been expunged from your record? (crime means felonies and misdemeanors, including vehicular misdemeanors and felonies) or been released from prison? (Examples of vehicular misdemeanors and felonies include reckless driving, driving while license has been suspended, driving without insurance, DUI’s involuntary manslaughter, damage to property, etc. Prison includes time spent in city and county jails as well as local, state, and federal prisons.) Applicants for employment in Hawaii should not answer this question at this time. Applicants in California should not answer this question as it relates to marijuana-related convictions more than 2 years old under California Health and Safety Code Sections 11357 (b) and (c), 11360 (c) 11364, 11365 or 11550.',
            listNumber: ' 1. '),
        AppGroupRadioBox(
            onchange: (e) {
              setState(() {
                widget.qValue = e ?? 'No';
              });
            },
            direction: OptionsOrientation.horizontal,
            name: 'response_1',
            options: const ['Yes', 'No']),
        const SizedBox(height: 8),
        widget.qValue == 'Yes'
            ? Column(
                children: [
                  AppDateField(
                    error: widget.fieldsError('response_1_date'),
                    bottom: 16,
                    name: 'response_1_date',
                    label: 'Date',
                  ),
                  AppTextField(
                    type: TextInputType.streetAddress,
                    error: widget.fieldsError('response_1_state'),
                    bottom: 16,
                    name: 'response_1_state',
                    label: 'State',
                  ),
                  AppTextField(
                    type: TextInputType.streetAddress,
                    error: widget.fieldsError('response_1_city'),
                    bottom: 16,
                    name: 'response_1_city',
                    label: 'City',
                  ),
                  AppTextField(
                    error: widget.fieldsError('response_1_note'),
                    bottom: 16,
                    type: TextInputType.multiline,
                    name: 'response_1_note',
                    label: 'Note',
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
    ;
  }
}

class Step5 extends StatefulWidget {
  Step5(
      {super.key,
      required this.onSelect,
      required this.fieldsError,
      required this.qValue});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;
  String qValue;

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Please Check The Following Question',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        const ListItem(
            text:
                'Are you currently on probation or parole for a criminal offense or have you received an alternative disposition sentence for a criminal act?',
            listNumber: ' 2. '),
        AppGroupRadioBox(
            onchange: (e) {
              setState(() {
                widget.qValue = e ?? 'No';
              });
            },
            direction: OptionsOrientation.horizontal,
            name: 'response_2',
            options: const ['Yes', 'No']),
        const SizedBox(height: 8),
        widget.qValue == 'Yes'
            ? Column(
                children: [
                  AppDateField(
                    error: widget.fieldsError('response_2_date'),
                    bottom: 16,
                    name: 'response_2_date',
                    label: 'Date',
                  ),
                  AppTextField(
                    type: TextInputType.streetAddress,
                    error: widget.fieldsError('response_2_state'),
                    bottom: 16,
                    name: 'response_2_state',
                    label: 'State',
                  ),
                  AppTextField(
                    type: TextInputType.streetAddress,
                    error: widget.fieldsError('response_2_city'),
                    bottom: 16,
                    name: 'response_2_city',
                    label: 'City',
                  ),
                  AppTextField(
                    error: widget.fieldsError('response_2_note'),
                    bottom: 16,
                    type: TextInputType.multiline,
                    name: 'response_2_note',
                    label: 'Note',
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}

class Step6 extends StatefulWidget {
  Step6({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  State<Step6> createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListItem(
            text: 'Name the specific court that adjudicated the admitted hit.',
            listNumber: ' 3. '),
        const SizedBox(height: 8),
        Column(
          children: [
            AppTextField(
              error: widget.fieldsError('court_name'),
              bottom: 16,
              type: TextInputType.text,
              name: 'court_name',
              label: 'Court Name',
            ),
            AppDateField(
              error: widget.fieldsError('court_date'),
              bottom: 16,
              name: 'court_date',
              label: 'Date',
            ),
            AppTextField(
              type: TextInputType.streetAddress,
              error: widget.fieldsError('q3_state'),
              bottom: 16,
              name: 'court_state',
              label: 'State',
            ),
          ],
        ),
        AppTypography(
            text:
                "I certify that the information contained herein is true and understand that any falsification will result in the rejection of my application or termination of my employment. I also understand that the requested information is for the sole purpose of conducting a background investigation which may include a check of my identity, work history, education history, credit history, driving records, any criminal history which may be in the files of any federal, state or local criminal agency, and a post offer search of workers’ compensation claim history. Information regarding age, sex, or race will not be used as part of any employment decision. I agree that a facsimile (“fax”), electronic or photographic copy of this Authorization shall be as valid as the original.",
            size: 14,
            color: AppColorScheme().black60),
        AppCheckBox(
          validator: FormBuilderValidators.equal(
            true,
            errorText: 'You must accept to continue',
          ),
          label: 'I agree to this top info.',
          name: 'agree',
        ),
        const SizedBox(height: 12),
        AppTextField(
          error: widget.fieldsError('print_name'),
          bottom: 16,
          type: TextInputType.text,
          name: 'print_name',
          label: 'Print Name',
        ),
      ],
    );
    ;
  }
}
