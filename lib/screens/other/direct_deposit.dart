import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../core/http.dart';
import '../../shared/theme/color.dart';
import '../../widgets/messages/snack_bar.dart';
import '../../widgets/others/back_layout.dart';
import '../../widgets/inputs/check_box.dart';
import '../../widgets/inputs/date_field.dart';
import '../../widgets/inputs/select_field.dart';
import '../../widgets/inputs/text_field.dart';

class DirectDepositScreen extends StatefulWidget {
  const DirectDepositScreen({super.key});
  static const route = '/direct-deposit';

  @override
  State<DirectDepositScreen> createState() => _DirectDepositScreenState();
}

class _DirectDepositScreenState extends State<DirectDepositScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  void changeSelectValue(String name, String value) {
    _formKey.currentState!.fields[name]!.didChange(value);
  }

  String? fieldsErrors(String name) {
    if (_formKey.currentState!.fields[name] == null) {
      return null;
    } else {
      return _formKey.currentState!.fields[name]!.errorText;
    }
  }

  Object fieldsValue(String name) {
    if (_formKey.currentState!.value[name] == null) {
      return '';
    } else {
      return _formKey.currentState!.value[name];
    }
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
                  initialValue: {
                    'name': '',
                    'address': '',
                    'city': '',
                    'state': '',
                    'zip_code': '',
                    'bank_name': '',
                    'routing_number': '',
                    'account_number': '',
                    'depositor_type_account': '',
                    'date': DateTime.now(),
                    'agree': false
                  },
                  skipDisabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DepositForm(
                          fieldsValue: fieldsValue,
                          onSelect: changeSelectValue,
                          fieldsError: fieldsErrors),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: loading ? null: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            print('aaaaaaaa');
                            setState(() {
                              loading = true;
                            });
                            var http = HttpRequest();
                            var body = {..._formKey.currentState?.value ?? {}};
                            var formatBody = body.map<String, String>((key, value) => MapEntry(key, value.toString()));
                            http.depositForm(formatBody).then((value){
                              setState(() {
                                loading = false;
                              });
                              if( value.success == true ){
                                SnackBarMessage
                                    .successSnackbar(context, "Direct Deposit save successfully");
                                Navigator.pop(context);
                              }else{
                                SnackBarMessage
                                    .errorSnackbar(
                                    context, value.message);
                              }
                            });
                          }
                        },
                        child: const Text('Finish'),
                      ),
                    ],
                  ))),
        ));
  }
}

class DepositForm extends StatelessWidget {
  const DepositForm(
      {super.key,
      required this.onSelect,
      required this.fieldsError,
      required this.fieldsValue});
  final void Function(String, String) onSelect;
  final String? Function(String) fieldsError;
  final Object Function(String) fieldsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTypography(
          text: 'Please Review or Edit the Information.',
          size: 24,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Name',
          error: fieldsError('name'),
          bottom: 16,
          type: TextInputType.name,
          name: 'name',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Name is required'),
          ]),
        ),
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
          error: fieldsError('city'),
          bottom: 16,
          name: 'city',
          label: 'City',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'City is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('state'),
          bottom: 16,
          name: 'state',
          label: 'State',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'State is required'),
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
        AppTextField(
          error: fieldsError('router_number'),
          bottom: 16,
          type: TextInputType.number,
          name: 'router_number',
          label: 'Router Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Router Number is required'),
          ]),
        ),
        AppTextField(
          error: fieldsError('account_number'),
          bottom: 16,
          type: TextInputType.number,
          name: 'account_number',
          label: 'Account Number',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Account Number is required'),
          ]),
        ),
        AppSelectField(
          error: fieldsError('depositor_type_account'),
          title: 'Select the depositor account',
          bottom: 16,
          onSelect: onSelect,
          option: const ["Savings"],
          name: 'depositor_type_account',
          label: 'Depositor Account',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: 'Depositor account is required'),
          ]),
        ),
        AppDateField(
          error: fieldsError('date'),
          bottom: 24,
          name: 'date',
          label: 'Date',
        ),
        AppTypography(
            text:
                "In signing this form authorize my payment to be sent to the financial institution name above to be deposited to the designated.",
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
      ],
    );
  }
}
