import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/auth/sing_up.dart';
import 'package:flutterapi/main.dart';
import 'package:flutterapi/main/home.dart';
import 'package:flutterapi/user.dart';
import 'package:flutterapi/widgets/custom_button.dart';
import 'package:flutterapi/widgets/text_field_obscure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
   late SharedPreferences shared;

  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController maintxt = TextEditingController();
  bool isObscure = true;
  bool _isValid = true;

Future<void> initShared() async{
     shared=await SharedPreferences.getInstance();
      _loginController.text=  shared.getString('login')??"";
      _passwordController.text=shared.getString('password')??"";
  }

  @override
  void initState(){
    initShared();
    super.initState();
  }

  void _incrementCounter() async{
    setState(() {
      shared.setString("refreshToken", "");
      shared.setString("accessToken", "");
      shared.setString("password", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: SizedBox()),
                const Text(
                  "Авторизация",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26),
                ),
                const Expanded(child: SizedBox()),
                TextFormField(
                  controller: _loginController,
                  validator: (value) {
                    if (!_isValid) {
                      return null;
                    }
                    if (value!.isEmpty) {
                      return 'Поле логин пустое';
                    }
                    if (value.length < 3) {
                      return 'Логин должен быть не менее 3 символов';
                    }
                    if (value.contains(" ")) {
                      return 'Логин не должен содержать пробелы';
                    }
                    return null;
                  },
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (!_isValid) {
                      return null;
                    }
                    if (value!.isEmpty) {
                      return 'Поле пароль пустое';
                    }
                    if (value.contains(" ")) {
                      return 'Пароль не должен содержать пробелы';
                    }
                    return null;
                  },
                  maxLength: 8,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    suffixIcon: TextFieldObscure(
                        iconColor: Colors.blue,
                        isObscure: (value) {
                          setState(() {
                            isObscure = value;
                          });
                        }),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  content: 'Войти',
                  onPressed: () {
                    _isValid = true;
                    if (_key.currentState!.validate()) {
                      signIn();
                    } else {}
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  content: 'Регистрация',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                ),
                const Expanded(flex: 3, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      final User user = User(
          username: _loginController.text,
          password: _passwordController.text,
          email: '');
      final Dio dio = Dio();
      final response =
          await dio.post('http://10.0.2.2:8080/token', data: user);
      print(response.data['data']['refreshToken']);
      await shared.setString("refreshToken", response.data['data']['refreshToken']);
      await shared.setString("accessToken", response.data['data']['accessToken']);
      await shared.setString("password", _passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeAdmin()),
      );
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {Navigator.of(context).pop();},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Ошибка!"),
    content: Text("Неверный логин или пароль"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
