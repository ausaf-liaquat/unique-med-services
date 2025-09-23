import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/screens/auth/create_account/form_steps.dart';
import 'package:ums_staff/screens/auth/verification.dart';

import '../../../core/http.dart';
import '../../../shared/theme/color.dart';
import '../../../widgets/messages/snack_bar.dart';
import '../../../widgets/others/back_layout.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  static const route = '/create-account';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  dynamic resume;
  bool loading = false;
  int _currentStep = 0;

  void changeSelectValue(String name, dynamic value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  void updateResume(dynamic value) {
    setState(() {
      resume = value;
    });
  }

  String? fieldsErrors(String name) {
    if (_formKey.currentState!.fields[name] == null) {
      return null;
    } else {
      return _formKey.currentState!.fields[name]!.errorText;
    }
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      var http = HttpRequest();
      var body = {..._formKey.currentState?.value ?? {}};
      var formatBody = body.map<String, String>(
              (key, value) => MapEntry(key, value.toString()));

      if (resume != null) {
        formatBody['resume'] = (resume as File).path;
      }

      final response = await http.register(formatBody);

      setState(() {
        loading = false;
      });

      if (response.success == true) {
        Navigator.pushNamed(
            context,
            VerificationScreen.route,
            arguments: {'register': true}
        );
      } else {
        SnackBarMessage.errorSnackbar(context, response.message);
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      SnackBarMessage.errorSnackbar(
          context,
          'An error occurred during registration. Please try again.'
      );
      print('Registration error: $e');
    }
  }

  bool _validateStep1() {
    if (resume == null) {
      SnackBarMessage.errorSnackbar(context, 'Please upload resume to continue');
      return false;
    }

    final phone = _formKey.currentState?.value['phone']?.toString() ?? '';
    if (phone.isNotEmpty) {
      RegExp exp = RegExp(r'^1[0-9]+$');
      if (!exp.hasMatch(phone)) {
        SnackBarMessage.errorSnackbar(
            context, 'Please enter a valid phone number starting with 1');
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool smallDevice = MediaQuery.of(context).size.width >= 365;
    final List<Widget> steps = <Widget>[
      Step1(
          resume: resume,
          onSelect: changeSelectValue,
          fieldsError: fieldsErrors,
          updateResume: updateResume),
      Step2(onSelect: changeSelectValue, fieldsError: fieldsErrors),
    ];

    return BackLayout(
        totalTabs: 2,
        currentTabs: _currentStep,
        text: 'Apply Clinician',
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
                    'first_name': '',
                    'last_name': '',
                    'phone': '',
                    'zip_code': '',
                    'email': '',
                    'password': '',
                    'city': '',
                    'address': '',
                    'state': '',
                    'qualification_type': '',
                    'resume': '',
                    'agree': false
                  },
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modern Step Indicator
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Row(
                          children: [
                            _buildStepIndicator(0, "Step 1", _currentStep >= 0),
                            Container(
                              width: 40,
                              height: 2,
                              color: _currentStep >= 1
                                  ? Theme.of(context).colorScheme.primary
                                  : AppColorScheme().black30,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                            ),
                            _buildStepIndicator(1, "Step 2", _currentStep >= 1),
                          ],
                        ),
                      ),

                      steps[_currentStep],
                      const SizedBox(height: 40),

                      // Modern Button Container
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: smallDevice ? 40 : 0),
                        child: Column(
                          children: [
                            // Next/Finish Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () async {
                                  if (!(_formKey.currentState?.validate() ?? false)) {
                                    setState(() {});
                                    return;
                                  }

                                  if (_currentStep == 0) {
                                    if (_validateStep1()) {
                                      setState(() {
                                        _currentStep = 1;
                                      });
                                    }
                                  } else {
                                    await _submitForm();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
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
                                      _currentStep == 1 ? Icons.check_circle_outline : Icons.arrow_forward,
                                      size: 20,
                                      color: AppColorScheme().black0,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _currentStep == 1 ? 'Finish Application' : 'Continue to Next Step',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColorScheme().black0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: _currentStep == 0 ? 0 : 16),

                            // Back Button
                            if (_currentStep > 0)
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextButton.icon(
                                  onPressed: loading ? null : () {
                                    setState(() {
                                      _currentStep = _currentStep - 1;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: AppColorScheme().black60,
                                  ),
                                  label: Text(
                                    'Back to Previous Step',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColorScheme().black60,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ))),
        ));
  }

  // Modern Step Indicator Widget
  Widget _buildStepIndicator(int stepNumber, String label, bool isCompleted) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                color: isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : AppColorScheme().black30,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                '${stepNumber + 1}',
                style: TextStyle(
                  color: isCompleted
                      ? Colors.white
                      : AppColorScheme().black30,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isCompleted
                  ? Theme.of(context).colorScheme.primary
                  : AppColorScheme().black60,
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}