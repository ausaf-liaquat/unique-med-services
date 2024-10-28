import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ums_staff/screens/auth/login.dart';
import 'package:ums_staff/shared/router/router.dart';
import 'package:ums_staff/shared/theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0)).then((value) => {FlutterNativeSplash.remove()});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unique Med Service',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData().lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: LoginScreen.route,
      routes: appRoutes,
    );
  }
}
