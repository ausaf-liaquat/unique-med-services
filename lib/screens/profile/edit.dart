import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/core/http.dart';
import 'package:ums_staff/screens/profile/model.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/shared/utils/image_picker.dart';
import 'package:ums_staff/widgets/card/upload_file.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import 'package:ums_staff/widgets/inputs/text_field.dart';
import 'package:ums_staff/widgets/messages/snack_bar.dart';
import 'package:ums_staff/widgets/others/back_layout.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const route = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  File? _profileImage;
  bool loading = false;
  Profile? _profile;
  bool _imageUpdated = false; // Flag to track if image was updated

  @override
  void initState() {
    super.initState();
    // Store profile data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      _profile = arguments['profile'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    _profile ??= arguments['profile'];

    return BackLayout(
      text: 'Edit Profile',
      page: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 44),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: {
              'first_name': _profile?.firstName ?? '',
              'last_name': _profile?.lastName ?? '',
              'qualification_type': _profile?.qualificationType ?? '',
              'email': _profile?.email ?? '',
              'phone': _profile?.phoneNumber ?? '',
              'address': _profile?.address ?? '',
              'city': _profile?.city ?? '',
              'state': _profile?.state ?? '',
              'zip_code': _profile?.zipCode ?? ''
            },
            skipDisabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image Section
                _buildProfileImageSection(),
                const SizedBox(height: 32),

                // Personal Information Section
                _buildSectionHeader('Personal Information', Icons.person_outline),
                const SizedBox(height: 20),
                _buildModernTextField('first_name', 'First Name', Icons.person, TextInputType.name, initialValue: _profile?.firstName ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('last_name', 'Last Name', Icons.person_outlined, TextInputType.name, initialValue: _profile?.lastName ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('email', 'Email', Icons.email_outlined, TextInputType.emailAddress, initialValue: _profile?.email ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('phone', 'Phone Number', Icons.phone_outlined, TextInputType.phone, initialValue: _profile?.phoneNumber ?? ''),

                const SizedBox(height: 32),

                // Location Information Section
                _buildSectionHeader('Location Information', Icons.location_on_outlined),
                const SizedBox(height: 20),
                _buildModernTextField('address', 'Address', Icons.home_outlined, TextInputType.streetAddress, initialValue: _profile?.address ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('city', 'City', Icons.location_city_outlined, TextInputType.text, initialValue: _profile?.city ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('state', 'State', Icons.map_outlined, TextInputType.text, initialValue: _profile?.state ?? ''),
                const SizedBox(height: 16),
                _buildModernTextField('zip_code', 'Zip Code', Icons.numbers_outlined, TextInputType.number, initialValue: _profile?.zipCode ?? ''),

                const SizedBox(height: 40),

                // Save Button
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColorScheme().black90,
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextField(String name, String label, IconData icon, TextInputType type, {String initialValue = ''}) {
    return FormBuilderTextField(
      name: name,
      keyboardType: type,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColorScheme().black60,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColorScheme().black60,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColorScheme().black30,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColorScheme().black30,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColorScheme().black6,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: '$label is required'),
        if (name == 'email') FormBuilderValidators.email(errorText: 'Please enter a valid email address'),
      ]),
    );
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: _profileImage != null
                    ? Image.file(
                  _profileImage!,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                )
                    : _profile?.imageUrl != null && _profile!.imageUrl!.isNotEmpty
                    ? Image.network(
                  _profile!.imageUrl!,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColorScheme().black10,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColorScheme().black10,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColorScheme().black40,
                      ),
                    );
                  },
                )
                    : Container(
                  color: AppColorScheme().black10,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColorScheme().black40,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColorScheme().black0,
                    width: 3,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 20,
                    color: AppColorScheme().black0,
                  ),
                  onPressed: () {
                    ImagePick.pickerImage(context, (File image) {
                      setState(() {
                        _profileImage = image;
                        _imageUpdated = true; // Set flag when new image is selected
                      });
                    });
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Profile Picture',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColorScheme().black70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _imageUpdated ? 'New image selected' : 'Tap camera icon to update',
          style: TextStyle(
            fontSize: 12,
            color: _imageUpdated ? Theme.of(context).colorScheme.primary : AppColorScheme().black50,
            fontWeight: _imageUpdated ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: loading
            ? null
            : () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            _updateProfile();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: AppColorScheme().black0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        child: loading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColorScheme().black0,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save_rounded,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'SAVE CHANGES',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    setState(() {
      loading = true;
    });

    var http = HttpRequest();
    var body = _formKey.currentState?.value ?? {};

    var formatBody = body.map<String, String>(
          (key, value) => MapEntry(key, value?.toString() ?? ''),
    );

    // 🚨 Ensure no old image sneaks in
    formatBody.remove('image');

    // ✅ Only add image if explicitly updated
    if (_imageUpdated && _profileImage != null) {
      formatBody['image'] = _profileImage!.path;
    }

    print('Sending update data: $formatBody'); // Debug log

    http.updateProfile(formatBody, imageFile: _imageUpdated ? _profileImage : null).then((response) {
      setState(() {
        loading = false;
        _imageUpdated = false; // Reset flag
      });

      if (response.success) {
        SnackBarMessage.successSnackbar(context, "Profile updated successfully");
        Navigator.pop(context);
      } else {
        SnackBarMessage.errorSnackbar(context, response.message);
      }
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      SnackBarMessage.errorSnackbar(context, "Failed to update profile");
    });
  }

}