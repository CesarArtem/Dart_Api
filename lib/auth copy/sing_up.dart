import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/auth/sing_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_field_obscure.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SharedPreferences shared;

  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool isObscure = true;
  Future<void> initShared() async {
    shared = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initShared();
    super.initState();
  }

  void _incrementCounter() async {
    setState(() {});

     await shared.setString("login", _loginController.text);
     await shared.setString("password", _passwordController.text);
      await shared.setString("refreshToken", "");
      await shared.setString("accessToken", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const Text(
                    'Регистрация',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                  const Spacer(),
                  TextFormField(
                    maxLength: 16,
                    controller: _loginController,
                    validator: (value) {
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
                    decoration: const InputDecoration(
                      hintText: 'Логин',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLength: 8,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Поле пароль пустое';
                      }
                      if (value.contains(" ")) {
                        return 'Пароль не должен содержать пробелы';
                      }
                      return null;
                    },
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      hintText: 'Пароль',
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
                  TextFormField(
                    maxLength: 32,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Поле с почтой пустое';
                      }
                      if (value.contains(" ")) {
                        return 'Почта не должна содержать пробелы';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Почта',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    content: 'Регистрация',
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        signUp();
                      } else {}
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    content: 'Вернуться',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                  ),
                  const Spacer(flex: 3),
                ]),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      final User user = User(
          username: _loginController.text,
          password: _passwordController.text,
          email: _emailController.text);
      final Dio dio = Dio();
      final response = await dio.put('http://localhost:8080/token', data: user);
      print(response.data);
      await shared.setString("login", _loginController.text);
      await shared.setString("password", _passwordController.text);
      await shared.setString("refreshToken", response.data['data']['refreshToken']);
      await shared.setString("accessToken", response.data['data']['accessToken']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    } catch (exception) {
      showAlertDialog(context);
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Ошибка!"),
    content: Text("Данный логин уже существует"),
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
