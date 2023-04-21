import 'package:flutter/material.dart';

class SnackBarMessage {
  static void  errorSnackbar( BuildContext context, String message){
    final snackBar = SnackBar(
      content: Row(children: [
        const Icon(Icons.error_outline, color: Colors.white,size: 24,),
        const SizedBox(width: 10,),
        Text(message)
      ],),
      backgroundColor: (Colors.red),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.85, left: 20, right: 20 ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void  successSnackbar( BuildContext context, String message){
    final snackBar = SnackBar(
      content: Row(children: [
        const Icon(Icons.check, color: Colors.white,size: 24,),
        const SizedBox(width: 10,),
        Text(message)
      ],),
      backgroundColor: (Colors.green),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.85, left: 20, right: 20 ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void  waringSnackbar( BuildContext context, String message){
    final snackBar = SnackBar(
      content: Row(children: [
        const Icon(Icons.warning_amber, color: Colors.white,size: 24,),
        const SizedBox(width: 10,),
        Text(message)
      ],),
      backgroundColor: (Colors.amber),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.85, left: 20, right: 20 ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}