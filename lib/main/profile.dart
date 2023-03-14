import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/auth/sing_up.dart';
import 'package:flutterapi/main/home.dart';
import 'package:flutterapi/user.dart';
import 'package:flutterapi/widgets/custom_button.dart';
import 'package:flutterapi/widgets/text_field_obscure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  bool isObscure = true;
  bool _isValid = true;
  late SharedPreferences shared;

  late String accessToken, refreshToken;

  Future<void> initShared() async {
    shared = await SharedPreferences.getInstance();
    refreshToken = shared.getString('refreshToken') ?? "";
    accessToken = shared.getString('accessToken') ?? "";
  }

  @override
  void initState() {
    initShared();
    super.initState();
  }

  void _incrementCounter() async {
    setState(() {});
  }

  void getUser() async {
    final Dio dio = Dio();
    shared = await SharedPreferences.getInstance();
    accessToken = shared.getString('accessToken') ?? "";
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    final response = await dio.get('http://10.0.2.2:8080/user');
    print(response.data);
    _loginController.text = response.data['data']['userName'];
    _emailController.text = response.data['data']['email'];
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Профиль',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(height: 50),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                      if (value != _password2Controller.text) {
                        return 'Пароли не совпадают';
                      }
                      return null;
                    },
                    maxLength: 8,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Повторите пароль',
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _password2Controller,
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
                      if (value != _passwordController.text) {
                        return 'Пароли не совпадают';
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
                  SizedBox(height: 20),
                  CustomButton(
                    content: 'Сохранить изменения',
                    onPressed: () {
                      _isValid = true;
                      if (_key.currentState!.validate()) {
                        SaveChanges();
                      } else {}
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    content: 'Изменить пароль',
                    onPressed: () {
                      _isValid = true;
                      if (_key.currentState!.validate()) {
                        NewPassword();
                      } else {}
                    },
                  ),
                  // const Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SaveChanges() async {
    try {
      String checkpswd = shared.getString('password') ?? "";
      if (_passwordController.text == checkpswd) {
        final User user = User(
            username: _loginController.text,
            password: _passwordController.text,
            email: _emailController.text);
        accessToken = shared.getString('accessToken') ?? "";
        final Dio dio = Dio();
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        final response =
            await dio.post('http://10.0.2.2:8080/user', data: user);
            print(response.data);
      }
      else
        showAlertDialog(context);
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }


  void NewPassword() async {
    try {
      String checkpswd = shared.getString('password') ?? "";
      if (_passwordController.text != checkpswd) {
        
        accessToken = shared.getString('accessToken') ?? "";
        final Dio dio = Dio();
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        final response =
            await dio.put('http://10.0.2.2:8080/user?newPassword='+_passwordController.text+'&oldPassword='+checkpswd);
            print(response.data);

        await shared.setString("password", _passwordController.text);
      }
      else
        showAlertDialog(context);
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
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Ошибка!"),
    content: Text("Ошибка"),
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
