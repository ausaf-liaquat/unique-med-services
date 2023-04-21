import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ums_staff/widgets/dataDisplay/typography.dart';
import '../../widgets/common/back_layout.dart';
import '../../widgets/common/date_field.dart';
import '../../widgets/common/select_field.dart';
import '../../widgets/common/switch.dart';

class FilterShiftScreen extends StatefulWidget {
  const FilterShiftScreen({super.key});
  static const route = '/shift/filter';

  @override
  State<FilterShiftScreen> createState() => _FilterShiftScreenState();
}

class _FilterShiftScreenState extends State<FilterShiftScreen> {
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
        text: 'Filter Shifts',
        page: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 44),
              child: FormBuilder(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: {
                    'date': DateTime.now(),
                    'type': '',
                    'facility': '',
                    'block': false
                  },
                  skipDisabled: true,
                  child: Column(
                    children: [
                      const AppTypography(
                        text: 'Filter shift detail for getting best Result. ',
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                      const SizedBox(height: 24),
                      AppDateField(
                        error: _formKey.currentState?.fields['date']!.errorText,
                        bottom: 24,
                        name: 'date',
                        label: 'Shift Date',
                      ),
                      AppSelectField(
                        error: _formKey.currentState?.fields['type']!.errorText,
                        title: 'What is your shift type?',
                        bottom: 24,
                        onSelect: changeSelectValue,
                        option: const [],
                        name: 'type',
                        label: 'Shift Type',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Shift type is required'),
                        ]),
                      ),
                      AppSelectField(
                        error: _formKey
                            .currentState?.fields['facility']!.errorText,
                        title: 'What is your facility?',
                        bottom: 16,
                        onSelect: changeSelectValue,
                        option: const [],
                        name: 'facility',
                        label: 'Facility',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Facility is required'),
                        ]),
                      ),
                      const AppSwitch(
                        name: 'block',
                        title: 'Bocked',
                        subTitle: 'Shift that are booked',
                      ),
                      const SizedBox(height: 110),
                      SizedBox(
                        width: 270,
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
                      SizedBox(
                        width: 270,
                        child: OutlinedButton(
                          child: const Text('Reset'),
                          onPressed: () {
                            setState(() {
                              _formKey.currentState!.fields['facility']
                                  ?.reset();
                              _formKey.currentState!.fields['type']?.reset();
                              _formKey.currentState!.fields['block']?.reset();
                              _formKey.currentState!.fields['date']
                                  ?.didChange(DateTime.now());
                            });
                          },
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
