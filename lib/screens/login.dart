import 'package:flutter/material.dart';
import 'package:ums_staff/shared/theme/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          heightFactor: 1.9,
          child: Image.asset('assets/images/logo.png', width: 150),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(children: const [Text('123131')]),
          ),
        ),
        Container(
          width: 260,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0),
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
    );
  }
}
