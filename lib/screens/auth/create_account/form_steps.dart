import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../shared/theme/color.dart';
import '../../../shared/utils/web_redirect.dart';
import '../../../widgets/card/upload_file.dart';
import '../../../widgets/inputs/check_box.dart';
import '../../../widgets/inputs/group_check_box.dart';
import '../../../widgets/inputs/group_radio_box.dart';
import '../../../widgets/inputs/select_field.dart';
import '../../../widgets/dataDisplay/typography.dart';

class Step1 extends StatelessWidget {
  const Step1({
    super.key,
    required this.onSelect,
    required this.fieldsError,
    required this.updateResume,
    this.resume,
  });

  final void Function(String, dynamic) onSelect;
  final void Function(dynamic) updateResume;
  final String? Function(String) fieldsError;
  final File? resume;

  Future<void> resumePick() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        updateResume(File(result.files.single.path!));
      }
    } catch (e) {
      debugPrint('Resume pick error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const AppTypography(
                      text: 'Basic Information',
                      size: 24,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppTypography(
                  text:
                  "First, we just need some basic information to get started.",
                  size: 14,
                  color: AppColorScheme().black60,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // First Name
          _buildModernTextField(
            context: context,
            error: fieldsError('first_name'),
            icon: Icons.person_outlined,
            label: 'First Name',
            type: TextInputType.name,
            name: 'first_name',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'First name is required'),
            ]),
            onSelect: onSelect,
          ),

          // Last Name
          _buildModernTextField(
            context: context,
            error: fieldsError('last_name'),
            icon: Icons.person_outlined,
            label: 'Last Name',
            type: TextInputType.name,
            name: 'last_name',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Last name is required'),
            ]),
            onSelect: onSelect,
          ),

          // Phone
          _buildModernTextField(
            context: context,
            error: fieldsError('phone'),
            icon: Icons.phone_outlined,
            label: 'Mobile Number',
            type: TextInputType.phone,
            name: 'phone',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Phone number is required'),
            ]),
            onSelect: onSelect,
          ),

          // Address
          _buildModernTextField(
            context: context,
            error: fieldsError('address'),
            icon: Icons.home_outlined,
            label: 'Address',
            type: TextInputType.streetAddress,
            name: 'address',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Address is required'),
            ]),
            onSelect: onSelect,
          ),

          // State
          _buildModernTextField(
            context: context,
            error: fieldsError('state'),
            icon: Icons.location_on_outlined,
            label: 'State',
            type: TextInputType.streetAddress,
            name: 'state',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'State is required'),
            ]),
            onSelect: onSelect,
          ),

          // City
          _buildModernTextField(
            context: context,
            error: fieldsError('city'),
            icon: Icons.location_city_outlined,
            label: 'City',
            type: TextInputType.streetAddress,
            name: 'city',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'City is required'),
            ]),
            onSelect: onSelect,
          ),

          // Zip Code
          _buildModernTextField(
            context: context,
            error: fieldsError('zip_code'),
            icon: Icons.numbers_outlined,
            label: 'Zip Code',
            type: TextInputType.number,
            name: 'zip_code',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Zip code is required'),
            ]),
            onSelect: onSelect,
          ),

          // Email
          _buildModernTextField(
            context: context,
            error: fieldsError('email'),
            icon: Icons.email_outlined,
            label: 'Email',
            type: TextInputType.emailAddress,
            name: 'email',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Email is required'),
              FormBuilderValidators.email(errorText: 'Invalid email address'),
            ]),
            onSelect: onSelect,
          ),

          // Password
          _buildModernTextField(
            context: context,
            error: fieldsError('password'),
            icon: Icons.lock_outlined,
            label: 'Password',
            type: TextInputType.visiblePassword,
            name: 'password',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Password is required'),
              FormBuilderValidators.minLength(6, errorText: 'Password must be at least 6 characters'),
              FormBuilderValidators.match(
                RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$'),
                errorText: 'Password must contain letters and numbers',
              ),
            ]),
            onSelect: onSelect,
          ),

          const SizedBox(height: 16),

          // Resume Upload
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.attach_file_outlined,
                    color: AppColorScheme().black60,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  AppTypography(
                    text: 'Resume Upload',
                    size: 16,
                    weight: FontWeight.w500,
                    color: AppColorScheme().black80,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: resumePick,
                child: Container(
                  height: 150,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 2,
                      color: resume == null ? AppColorScheme().black30 : Theme.of(context).colorScheme.primary,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: resume == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: AppColorScheme().black40,
                      ),
                      const SizedBox(height: 8),
                      AppTypography(
                        text: 'Upload Your Resume',
                        size: 14,
                        weight: FontWeight.w500,
                        color: AppColorScheme().black60,
                      ),
                      const SizedBox(height: 2),
                      AppTypography(
                        text: 'PDF, DOC, DOCX up to 10MB',
                        size: 10,
                        color: AppColorScheme().black40,
                      ),
                    ],
                  )
                      : UploadFileCard(file: resume),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required BuildContext context,
    required String? error,
    required IconData icon,
    required String label,
    required TextInputType type,
    required String name,
    required FormFieldValidator<String>? validator,
    required void Function(String, dynamic) onSelect,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: FormBuilderTextField(
        name: name,
        keyboardType: type,
        obscureText: type == TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColorScheme().black60,
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: AppColorScheme().black60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColorScheme().black30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColorScheme().black30),
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
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: validator,
        onChanged: (value) {
          onSelect(name, value);
        },
      ),
    );
  }
}

class Step2 extends StatefulWidget {
  const Step2({super.key, required this.onSelect, required this.fieldsError});
  final void Function(String, dynamic) onSelect;
  final String? Function(String) fieldsError;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const AppTypography(
                      text: 'Professional Details',
                      size: 24,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppTypography(
                  text: "Tell us about your qualifications and preferences.",
                  size: 14,
                  color: AppColorScheme().black60,
                ),
              ],
            ),
          ),

          // Qualification Type
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AppSelectField(
              error: widget.fieldsError('qualification_type'),
              title: 'Select the qualification type?',
              bottom: 0,
              onSelect: widget.onSelect,
              option: const ['RN', 'MT', 'PST', 'PCT', 'PT', 'OT', 'RT', 'EKG', 'LPN / LVN', 'CNA / SRNA / GNA / LNA / STNA / NAC', 'CMA / QMAP / MAPS / LMA / CMT / RMA / UAP / AMAP'],
              name: 'qualification_type',
              label: 'Qualification Type',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Qualification type is required'),
              ]),
            ),
          ),

          // Shifts Section
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColorScheme().black20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: AppTypography(
                        text: 'What types of shifts are you interested in?',
                        size: 14,
                        weight: FontWeight.w600,
                        color: AppColorScheme().black80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppGroupCheckBox(
                  name: 'shift',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1, errorText: 'At least select one option'),
                  ]),
                  options: const ['Day Shifts', 'Evening Shifts', 'Overnight Shifts', 'Weekend Shifts', 'Weekday Shifts'],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Experience Section
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColorScheme().black20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.work_history_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: AppTypography(
                        text: 'Select your licensed work experience:',
                        size: 14,
                        weight: FontWeight.w600,
                        color: AppColorScheme().black80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppGroupRadioBox(
                  name: 'experience',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1, errorText: 'At least select one option'),
                  ]),
                  options: const ['0 - 3 months', '4 - 6 months', '6+ months'],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Terms and Conditions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColorScheme().black6,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColorScheme().black20),
            ),
            child: AppCheckBox(
              validator: FormBuilderValidators.equal(
                true,
                errorText: 'You must accept to continue',
              ),
              text: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: 'I have read and agree to Unique Med Services ',
                  style: TextStyle(color: AppColorScheme().black60, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          WebRedirect().termsAndConditions(context);
                        },
                      text: 'Terms of Service',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: ', '),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          WebRedirect().privacyPolicy(context);
                        },
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          WebRedirect().termsAndConditions(context);
                        },
                      text: 'SMS Terms of Service',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              name: 'agree',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
