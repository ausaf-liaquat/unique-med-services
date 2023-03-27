import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ums_staff/shared/theme/color.dart';
import 'package:ums_staff/widgets/common/typography.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            heightFactor: 1.9,
            child: Image.asset('assets/images/logo.png', width: 150),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.30),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FormBuilderTextField(
                            name: 'email',
                            style: TextStyle(
                              color: AppColorScheme().black80,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 12, bottom: 12),
                                label: AppTypography(
                                  text: 'Username or Email:',
                                  size: 15,
                                  color: AppColorScheme().black50,
                                  spacing: 0.4,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColorScheme().black0),
                                ),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppColorScheme().black0),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            width: 260,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By using the app, you agree to our ',
                style: TextStyle(
                    color: AppColorScheme().black90,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    height: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Privacy policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                  const TextSpan(text: ' and '),
                  TextSpan(
                      text: 'Terms of Service.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
