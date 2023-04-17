import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/select_field.dart';
import '../../widgets/common/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const route = '/profile/edit/123';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    return BackLayout(
        text: 'Edit Profile',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 44),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'name': '',
                    'clinician': '',
                    'email': '',
                    'phone': '',
                    'address': '',
                    'city': '',
                    'state': '',
                    'code': ''
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
                      AppTextField(
                        error: _formKey.currentState?.fields['name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        name: 'name',
                        label: 'Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Name is required'),
                        ]),
                      ),
                      AppSelectField(
                        error: _formKey
                            .currentState?.fields['clinician']!.errorText,
                        title: 'What is your clinician?',
                        bottom: 16,
                        onSelect: changeSelectValue,
                        option: const [],
                        name: 'clinician',
                        label: 'Clinician',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Clinician is required'),
                        ]),
                      ),
                      AppTextField(
                        error:
                            _formKey.currentState?.fields['email']!.errorText,
                        bottom: 16,
                        type: TextInputType.emailAddress,
                        name: 'email',
                        label: 'Email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Email is required'),
                        ]),
                      ),
                      AppTextField(
                        error:
                            _formKey.currentState?.fields['phone']!.errorText,
                        bottom: 28,
                        type: TextInputType.phone,
                        name: 'phone',
                        label: 'Phone Number',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Phone number is required'),
                        ]),
                      ),
                      const AppTypography(
                        text: 'Location',
                        size: 24,
                        weight: FontWeight.w500,
                      ),
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
                              errorText: 'Address is required'),
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
                              errorText: 'City is required'),
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
                        bottom: 64,
                        type: TextInputType.number,
                        name: 'code',
                        label: 'Zip Code',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Zip code is required'),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // error funtion
                            } else {
                              setState(() {});
                              // sucess funtion
                            }
                          },
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Save Changes'),
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
