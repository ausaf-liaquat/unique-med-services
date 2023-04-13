import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/text_field.dart';

class DirectDepositScreen extends StatefulWidget {
  const DirectDepositScreen({super.key});
  static const route = '/direct-deposit';

  @override
  State<DirectDepositScreen> createState() => _DirectDepositScreenState();
}

class _DirectDepositScreenState extends State<DirectDepositScreen> {
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
        text: 'Direct Deposit',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 26, 20, 32),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: const {
                    'first_name': '',
                    'last_name': '',
                    'router_number': '',
                    'conform_router_number': '',
                    'account_number': '',
                    'conform_account_number': '',
                  },
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTypography(
                        text: 'Filter shift detail for getting best Result.',
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['first_name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        name: 'first_name',
                        label: 'First Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'First Name is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['last_name']!.errorText,
                        bottom: 16,
                        type: TextInputType.name,
                        name: 'last_name',
                        label: 'Last Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Last Name is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['router_number']!.errorText,
                        bottom: 16,
                        type: TextInputType.number,
                        name: 'router_number',
                        label: 'Router Number',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Router Number is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey.currentState
                            ?.fields['conform_router_number']!.errorText,
                        bottom: 16,
                        type: TextInputType.number,
                        name: 'conform_router_number',
                        label: 'Conform Router Number',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.equal(
                              _formKey.currentState?.value['router_number'] ??
                                  '',
                              errorText:
                                  'Conform router number number must be same as router number'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey
                            .currentState?.fields['account_number']!.errorText,
                        bottom: 16,
                        type: TextInputType.number,
                        name: 'account_number',
                        label: 'Account Number',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Account Number is mendatory'),
                        ]),
                      ),
                      AppTextField(
                        error: _formKey.currentState
                            ?.fields['conform_account_number']!.errorText,
                        bottom: 48,
                        type: TextInputType.number,
                        name: 'conform_account_number',
                        label: 'Conform Account Number',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.equal(
                              _formKey.currentState?.value['account_number'] ??
                                  '',
                              errorText:
                                  'Conform account number must be same as account number'),
                        ]),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // error funtion
                          } else {
                            setState(() {});
                            // sucess funtion
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ))),
        ));
  }
}
