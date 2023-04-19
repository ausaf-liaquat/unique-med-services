import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../shared/theme/color.dart';
import '../../../shared/utils/initial_data.dart';
import '../../../widgets/common/check_box.dart';
import '../../../widgets/common/date_field.dart';
import '../../../widgets/common/select_field.dart';
import '../../../widgets/common/text_field.dart';
import '../../../widgets/dataDisplay/list_item.dart';
import '../../../widgets/dataDisplay/typography.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
            text:
                "Please Review or Edit the Information Below and Confirm It's Still Valid.",
            size: 24,
            weight: FontWeight.w500),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "In order for you to get paid, you must fill out this form. Nursa reports your income to the IRS but does not collect taxes. As an independent contractor, you are responsible for paying your own taxes.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 10),
        AppTypography(
            text:
                "The W-9 form information and instructions can be found here: https://www.irs.gov/pub/irs- pdf/fw9.pdf",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 12),
        const AppTypography(
            text: "Certification", size: 24, weight: FontWeight.w500),
        const SizedBox(height: 12),
        AppTypography(
            text: "Under penalties of perjury, I certify that:",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 12),
        const ListItem(
          listNumber: ' 1. ',
          bottom: 12,
          text:
              'The number shown on this form is my correct taxpayer identification number (or I am waiting for a number to be issued to me).',
        ),
        const ListItem(
          listNumber: ' 2. ',
          bottom: 12,
          text:
              'I am not subject to backup withholding because: (a) I am exempt from backup withholding, or (b) I have not been notified by the Internal Revenue Service (IRS) that I am subject to backup withholding as a result of a failure to report all interest or dividends, or (c) the IRS has notified me that I am no longer subject to backup withholding.',
        ),
        const ListItem(
          listNumber: ' 3. ',
          bottom: 24,
          text:
              'I am a US citizen or other U.S. person (defined below); and 4. The FACTA code(s) entered on this form (if any) indicating that I am exempt from FACTA reporting is correct.',
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
            text: "Electronic Signature", size: 24, weight: FontWeight.w500),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "By typing your name below, you are confirming that you have read and are electronically signing this document.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 24),
        AppTextField(
          label: 'Name',
          error: fieldsError('name'),
          helpText: 'as shown on your income tax return',
          bottom: 16,
          type: TextInputType.name,
          name: 'name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Name is required'),
          ]),
        ),
        AppTextField(
          label: 'Disregarded Entity Name',
          error: fieldsError('entity_name'),
          helpText: 'if different from above name',
          bottom: 16,
          type: TextInputType.name,
          name: 'entity_name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Disregarded entity name is required'),
          ]),
        ),
        AppSelectField(
          error: fieldsError('federal_tax_classification'),
          title: 'What is Federal tax classification?',
          helpText: 'person who name is enter above',
          bottom: 16,
          name: 'federal_tax_classification',
          onSelect: onSelect,
          option: AppInitialData().federalTaxClassification,
          label: 'Federal Tax Classification',
        ),
        AppTextField(
          label: 'Tax Classification',
          error: fieldsError('tax_classification'),
          helpText: '(C=C corporation, S=S corporation, P=Partnership)',
          bottom: 16,
          type: TextInputType.name,
          name: 'tax_classification',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Tax classification is required'),
          ]),
        ),
        AppTextField(
          label: 'Payee Code',
          error: fieldsError('payee_code'),
          helpText: '(optional)',
          bottom: 16,
          type: TextInputType.name,
          name: 'payee_code',
        ),
        AppTextField(
          label: 'FATCA Reporting Code',
          error: fieldsError('reporting_code'),
          helpText: '(optional)',
          bottom: 16,
          type: TextInputType.name,
          name: 'reporting_code',
        ),
        AppTextField(
          label: 'List Account Number',
          error: fieldsError('list_account_number'),
          helpText: '(optional)',
          bottom: 16,
          type: TextInputType.name,
          name: 'list_account_number',
        ),
        AppTextField(
          label: 'Social Security Number',
          error: fieldsError('social_security_number'),
          bottom: 16,
          type: TextInputType.name,
          name: 'social_security_number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Social security number is required'),
          ]),
        ),
        AppTextField(
          label: 'Employer Identification Number',
          error: fieldsError('employer_identification_number'),
          helpText: '(optional)',
          bottom: 16,
          type: TextInputType.name,
          name: 'employer_identification_number',
        ),
        AppDateField(
          error: fieldsError('date'),
          bottom: 40,
          name: 'date',
          label: 'Date',
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
            text: "Requester’s (optional)", size: 24, weight: FontWeight.w500),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.",
            size: 14,
            color: AppColorScheme().black60),
        const SizedBox(height: 24),
        AppTextField(
          error: fieldsError('requester_first_name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'requester_first_name',
          label: 'First Name',
        ),
        AppTextField(
          error: fieldsError('requester_last_name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'requester_last_name',
          label: 'Last Name',
        ),
        AppTextField(
          error: fieldsError('requester_address'),
          bottom: 16,
          type: TextInputType.streetAddress,
          name: 'requester_address',
          label: 'Address',
        ),
        AppSelectField(
          error: fieldsError('requester_city'),
          title: 'What is requester city?',
          bottom: 16,
          onSelect: onSelect,
          option: const [],
          name: 'requester_city',
          label: 'City',
        ),
        AppSelectField(
          error: fieldsError('requester_state'),
          title: 'What is requester state?',
          bottom: 16,
          onSelect: onSelect,
          option: const [],
          name: 'requester_state',
          label: 'State',
        ),
        AppTextField(
          error: fieldsError('requester_code'),
          bottom: 16,
          type: TextInputType.number,
          name: 'requester_code',
          label: 'Zip Code',
        ),
      ],
    );
  }
}

class Step4 extends StatelessWidget {
  const Step4({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
            text: "Location", size: 24, weight: FontWeight.w500),
        const SizedBox(height: 12),
        AppTypography(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.",
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
        AppSelectField(
          error: fieldsError('city'),
          title: 'What is your city?',
          bottom: 16,
          onSelect: onSelect,
          option: const [],
          name: 'city',
          label: 'City',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'City is required'),
          ]),
        ),
        AppSelectField(
          error: fieldsError('state'),
          title: 'What is your state?',
          bottom: 16,
          onSelect: onSelect,
          option: const [],
          name: 'state',
          label: 'State',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'State is required'),
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
        AppTypography(
            text:
                "Certify that the information contained hersin is true and understand that any fatalfication will result is the rejection of my opplication.",
            size: 14,
            color: AppColorScheme().black60),
        const AppCheckBox(
          label: 'I agree to this top info.',
          name: 'agree',
        ),
      ],
    );
  }
}
