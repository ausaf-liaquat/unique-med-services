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

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Profile? profile = arguments['profile'];

    return BackLayout(
      text: 'Edit Profile',
      page: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 44),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: {
              'first_name': profile?.firstName ?? '',
              'last_name': profile?.lastName ?? '',
              'qualification_type': profile?.qualificationType ?? '',
              'email': profile?.email ?? '',
              'phone': profile?.phoneNumber ?? '',
              'address': profile?.address ?? '',
              'city': profile?.city ?? '',
              'state': profile?.state ?? '',
              'zip_code': profile?.zipCode ?? ''
            },
            skipDisabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppTypography(
                  text: 'Personal',
                  size: 24,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 16),
                buildTextField('first_name', 'First Name', TextInputType.name, 'First Name is required'),
                buildTextField('last_name', 'Last Name', TextInputType.name, 'Last Name is required'),
                buildTextField('email', 'Email', TextInputType.emailAddress, 'Email is required'),
                buildTextField('phone', 'Phone Number', TextInputType.phone, 'Phone number is required'),
                const AppTypography(
                  text: 'Location',
                  size: 24,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 16),
                buildTextField('address', 'Address', TextInputType.streetAddress, 'Address is required'),
                buildTextField('city', 'City', TextInputType.text, 'City is required'),
                buildTextField('state', 'State', TextInputType.text, 'State is required'),
                buildTextField('zip_code', 'Zip Code', TextInputType.number, 'Zip code is required'),
                const AppTypography(
                  text: 'Picture',
                  size: 24,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 16),
                buildProfileImagePicker(),
                const SizedBox(height: 45),
                buildSaveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String name, String label, TextInputType type, String errorText) {
    return AppTextField(
      error: _formKey.currentState?.fields[name]?.errorText,
      bottom: 16,
      type: type,
      name: name,
      label: label,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: errorText),
      ]),
    );
  }

  Widget buildProfileImagePicker() {
    return InkWell(
      onTap: () {
        ImagePick.pickerImage(context, (File image) {
          setState(() {
            _profileImage = image;
          });
        });
      },
      child: _profileImage == null
          ? Container(
              height: 150,
              decoration: BoxDecoration(
                  color: AppColorScheme().black0,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
              child: Center(
                  child: SizedBox(
                width: 140,
                child: AppTypography(
                  align: TextAlign.center,
                  text: 'Upload Profile Picture',
                  size: 16,
                  height: 1.4,
                  color: AppColorScheme().black60,
                ),
              )),
            )
          : UploadFileCard(file: _profileImage, useImage: true),
    );
  }

  Widget buildSaveButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: ElevatedButton.icon(
        onPressed: () {
          // Ensure form data is saved to include all fields
          _formKey.currentState?.save();

          if (_formKey.currentState?.validate() ?? false) {
            setState(() {
              loading = true;
            });
            var http = HttpRequest();
            var body = _formKey.currentState?.value ?? {};

            // Convert values to strings and include image path if present
            var formatBody = body.map<String, String>((key, value) => MapEntry(key, value.toString()));
            if (_profileImage != null) {
              formatBody['image'] = (_profileImage as File).path;
            }

            http.updateProfile(formatBody).then((response) {
              setState(() {
                loading = false;
              });
              if (response.success) {
                SnackBarMessage.successSnackbar(context, "Profile updated");
                Navigator.pop(context);
              } else {
                SnackBarMessage.errorSnackbar(context, response.message);
              }
            });
          }
        },
        icon: const Icon(Icons.save_outlined),
        label: const Text('Save Changes'),
      ),
    );
  }
}
