import 'package:flutter/material.dart';
import 'package:ums_staff/widgets/card/card.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
        child: Column(
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            height: 150,
            width: 96,
            decoration:
                BoxDecoration(shape: BoxShape.circle, boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/test/profile.jpg',
                      fit: BoxFit.cover,
                    )
                  ],
                )
              ],
            ))
      ],
    ));
  }
}
