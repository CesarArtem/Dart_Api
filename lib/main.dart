import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/auth/sing_in.dart';
import 'package:flutterapi/user.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        brightness: Brightness.light,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.green,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const SignIn(),
    );
  }
}
