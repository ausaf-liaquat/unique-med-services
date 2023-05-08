import 'package:flutter/material.dart';

class AppLink extends StatelessWidget {
  var params;

  AppLink(
      {super.key,
      required this.child,
      this.path,
      this.params,
      this.pop = false, this.onTap});

  final Widget child;
  final String? path;
  final bool pop;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: path == null
          ? onTap
          : () {
              pop ? Navigator.pop(context) : null;
              Navigator.pushNamed(context, path ?? '', arguments: params ?? {});
            },
      child: child,
    );
  }
}
