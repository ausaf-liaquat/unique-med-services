import 'package:flutter/material.dart';

class AppLink extends StatelessWidget {
  var params;

  AppLink(
      {super.key,
      required this.child,
      this.path,
      this.params,
      this.pop = false});

  final Widget child;
  final String? path;
  final bool pop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: path == null
          ? null
          : () {
              pop ? Navigator.pop(context) : null;
              Navigator.pushNamed(context, path ?? '', arguments: params ?? {});
            },
      child: child,
    );
  }
}
