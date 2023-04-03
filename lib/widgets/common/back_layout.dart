import 'package:flutter/material.dart';

class BackLayout extends StatelessWidget {
  const BackLayout({
    super.key,
    required this.page,
    required this.text,
  });
  final Widget page;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        ),
        title: Text(text),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/images/app-bar-logo.png', width: 51),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: page,
      )),
    );
  }
}
