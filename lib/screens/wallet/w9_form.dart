import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';

import '../../widgets/common/back_layout.dart';
import '../../widgets/common/select_field.dart';
import '../../widgets/common/text_field.dart';
import '../../widgets/dataDisplay/list_item.dart';

class W9FormScreen extends StatefulWidget {
  const W9FormScreen({super.key});
  static const route = '/w9-form';

  @override
  State<W9FormScreen> createState() => _W9FormScreenState();
}

class _W9FormScreenState extends State<W9FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 365;

    return BackLayout(
        text: 'ELectronic W-9',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'name': '',
                    'first_name': '',
                    'middle_name': '',
                    'last_name': '',
                    'address': '',
                    'city': '',
                    'state': '',
                    'code': '',
                    'social_security': '',
                    'conform_social_security': ''
                  },
                  skipDisabled: true,
                  child: Column(
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
                      const SizedBox(height: 20),
                      const AppTypography(
                          text: "Personal", size: 24, weight: FontWeight.w500),
                      const SizedBox(height: 16),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['first_name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        helpText: 'as shown on your income tax return',
                        name: 'first_name',
                        label: 'First Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'First Name is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['middle_name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        helpText: 'as shown on your income tax return',
                        name: 'middle_name',
                        label: 'Middle Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Middle Name is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['last_name']!.errorText,
                        bottom: 28,
                        type: TextInputType.name,
                        helpText: 'as shown on your income tax return',
                        name: 'last_name',
                        label: 'Last Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Last Name is mendatory'),
                        ]),
                      ),
                      const AppTypography(
                          text: "Location", size: 24, weight: FontWeight.w500),
                      const SizedBox(height: 16),
                      AppTextField(
                        error:
                            _formKey.currentState?.fields['address']!.errorText,
                        bottom: 16,
                        type: TextInputType.streetAddress,
                        name: 'address',
                        label: 'Address',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Address is mendatory'),
                        ]),
                      ),
                      AppSelectField(
                        error: _formKey.currentState?.fields['city']!.errorText,
                        title: 'What is your city?',
                        bottom: 16,
                        onSelect: changeSelectValue,
                        option: const [],
                        name: 'city',
                        label: 'City',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'City is mendatory'),
                        ]),
                      ),
                      AppSelectField(
                        error:
                            _formKey.currentState?.fields['state']!.errorText,
                        title: 'What is your state?',
                        bottom: 16,
                        onSelect: changeSelectValue,
                        option: const [],
                        name: 'state',
                        label: 'State',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'State'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey.currentState?.fields['code']!.errorText,
                        bottom: 16,
                        type: TextInputType.number,
                        name: 'code',
                        label: 'Zip Code',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Zip code is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['social_security']!.errorText,
                        bottom: 16,
                        name: 'social_security',
                        label: smallDevice
                            ? 'Social Security Number'
                            : 'Social Security',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Social security number is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey.currentState
                            ?.fields['conform_social_security']!.errorText,
                        bottom: 28,
                        name: 'conform_social_security',
                        label: smallDevice
                            ? 'Conform Social Security Number'
                            : 'Conform Social Security',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.equal(
                              _formKey.currentState?.value['social_security'] ??
                                  '',
                              errorText:
                                  'Conform social security number must be same as router number'),
                        ]),
                      ),
                      const AppTypography(
                          text: "Certification",
                          size: 24,
                          weight: FontWeight.w500),
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
                      const AppTypography(
                          text: "Electronic Signature",
                          size: 24,
                          weight: FontWeight.w500),
                      const SizedBox(height: 12),
                      AppTypography(
                          text:
                              "By typing your name below, you are confirming that you have read and are electronically signing this document.",
                          size: 14,
                          color: AppColorScheme().black60),
                      const SizedBox(height: 28),
                      AppTextField(
                        error: _formKey.currentState?.fields['name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        name: 'name',
                        label: 'Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Name is mendatory'),
                        ]),
                      ),
                      const SizedBox(height: 48),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallDevice ? 40 : 0),
                        child: ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // error funtion
                            } else {
                              setState(() {});
                              // sucess funtion
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallDevice ? 40 : 0),
                        child: TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
