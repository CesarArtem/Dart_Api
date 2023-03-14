import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapi/auth/sing_up.dart';
import 'package:flutterapi/finances.dart';
import 'package:flutterapi/main/home.dart';
import 'package:flutterapi/widgets/custom_button.dart';
import 'package:flutterapi/widgets/text_field_obscure.dart';

class finances extends StatefulWidget {
  const finances({Key? key}) : super(key: key);

  @override
  State<finances> createState() => _FinancesState();
}

class _FinancesState extends State<finances> {
  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nameOperationController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _kategoryController = TextEditingController();
  TextEditingController _summController = TextEditingController();

  List<Finances> list = <Finances>[];
  List<bool> listispressed = <bool>[];

  final Dio dio = Dio();

  void getList() async {
    final response = await dio.get('http://10.0.2.2:8080/finances?Search=');
    while (true) {
      try {
        Finances finances = new Finances(
            id: response.data[list.length]['id'],
            number: response.data[list.length]['number'],
            nameOperation: response.data[list.length]['nameOperation'],
            description: response.data[list.length]['description'],
            kategory: response.data[list.length]['kategory'],
            dateOperation: response.data[list.length]['dateOperation'],
            summ: response.data[list.length]['summ'],
            isdeleted: false);

        listispressed.add(false);
        list.add(finances);
        setState(() {});
      } catch (exception) {
        print(exception);
        break;
      }
    }
  }

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // padding: const EdgeInsets.all(8),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0;
                                      i < listispressed.length;
                                      i++) {
                                    listispressed[i] = false;
                                  }
                                  listispressed[index] = !listispressed[index];
                                  fillText();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                color: listispressed[index]
                                    ? Colors.red[100]
                                    : Colors.white,
                                child: Text(
                                    list[index].number +
                                        " " +
                                        list[index].nameOperation,
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                alignment: Alignment.center,
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        // color: Colors.black,
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form(
                                key: _key,
                                child: Row(children: [
                                  Column(children: [
                                    Container(
                                      width: 300,
                                      height: 80,
                                      child: TextFormField(
                                        maxLength: 6,
                                        controller: _numberController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Поле номера пустое';
                                          }
                                          if (value.contains(" ")) {
                                            return 'Номер не должен содержать пробелы';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Номер',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 80,
                                      child: TextFormField(
                                        maxLength: 20,
                                        controller: _nameOperationController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Поле название пустое';
                                          }
                                          if (value.length < 3) {
                                            return 'Название должно быть больше 3 символов';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Название',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 80,
                                      child: TextFormField(
                                        maxLength: 250,
                                        controller: _descriptionController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Поле описания пустое';
                                          }
                                          if (value.length < 5) {
                                            return 'Описание должно быть больше 5 символов';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Описание',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 80,
                                      child: TextFormField(
                                        maxLength: 20,
                                        controller: _kategoryController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Поле категории пустое';
                                          }
                                          if (value.contains(" ")) {
                                            return 'Категория не должна содержать пробелы';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Категория',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Column(children: [
                                      Container(
                                          height: 40,
                                          width: 300,
                                          child: Text(
                                              currentDate.year.toString() +
                                                  "/" +
                                                  currentDate.month.toString() +
                                                  "/" +
                                                  currentDate.day.toString())),
                                      Container(
                                        height: 40,
                                        width: 300,
                                        child: ElevatedButton(
                                          onPressed: () => _selectDate(context),
                                          child: Text('Дата операции'),
                                        ),
                                      ),
                                    ]),
                                    Container(
                                      height: 80,
                                      width: 300,
                                      child: TextField(
                                        controller: _summController,
                                        decoration: new InputDecoration(
                                            labelText: "Сумма"),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ]),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Container(
                                  child: Column(children: [
                                    Container(
                                      width: 200,
                                      child: CustomButton(
                                        content: 'Добавить',
                                        onPressed: () {
                                          if (_key.currentState!.validate()) {
                                            addFinance();
                                          } else {}
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: 200,
                                      child: CustomButton(
                                        content: 'Изменить',
                                        onPressed: () {
                                          if (_key.currentState!.validate()) {
                                            EditFinance();
                                          } else {}
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: 200,
                                      child: CustomButton(
                                        content: 'Удалить',
                                        onPressed: () {
                                          DeleteFinance();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: 200,
                                      child: CustomButton(
                                        content: 'Удалить логически',
                                        onPressed: () {
                                          DeleteLogFinance();
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              )
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void addFinance() async {
    try {
      final Finances finances = Finances(
          id: list[list.length - 1].id + 1,
          number: _numberController.text,
          nameOperation: _nameOperationController.text,
          description: _descriptionController.text,
          kategory: _kategoryController.text,
          dateOperation: currentDate.year.toString() +
              "/" +
              currentDate.month.toString() +
              "/" +
              currentDate.day.toString(),
          summ: int.parse(_summController.text),
          isdeleted: false);
      final Dio dio = Dio();
      final response =
          await dio.post('http://10.0.2.2:8080/finances', data: finances);
      list.clear();
      setState(() {});
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }

  void EditFinance() async {
    try {
      late int temp;
      for (int i = 0; i < listispressed.length; i++) {
        if (listispressed[i]) {
          temp = i;
          break;
        }
      }
      final Finances finances = Finances(
          id: list[temp].id,
          number: _numberController.text,
          nameOperation: _nameOperationController.text,
          description: _descriptionController.text,
          kategory: _kategoryController.text,
          dateOperation: currentDate.year.toString() +
              "/" +
              currentDate.month.toString() +
              "/" +
              currentDate.day.toString(),
          summ: int.parse(_summController.text),
          isdeleted: false);
      final Dio dio = Dio();
      final response = await dio.put(
          'http://10.0.2.2:8080/finances/' + list[temp].id.toString(),
          data: finances);
      list.clear();
      setState(() {});
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }

  void DeleteFinance() async {
    try {
      late int temp;
      for (int i = 0; i < listispressed.length; i++) {
        if (listispressed[i]) {
          temp = i;
          break;
        }
      }
      final Dio dio = Dio();
      final response = await dio
          .delete('http://10.0.2.2:8080/finances/' + list[temp].id.toString());
      list.clear();
      setState(() {});
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }

  void DeleteLogFinance() async {
    try {
      late int temp;
      for (int i = 0; i < listispressed.length; i++) {
        if (listispressed[i]) {
          temp = i;
          break;
        }
      }
      final Dio dio = Dio();
      final response = await dio
          .delete('http://10.0.2.2:8080/finances/options/' + list[temp].id.toString());
      list.clear();
      setState(() {});
    } catch (exception) {
      print(exception);
      showAlertDialog(context);
    }
  }

  void fillText() {
    try {
      late int temp;
      for (int i = 0; i < listispressed.length; i++) {
        if (listispressed[i]) {
          temp = i;
          break;
        }
      }
      _numberController.text = list[temp].number.toString();
      _nameOperationController.text = list[temp].nameOperation.toString();
      _descriptionController.text = list[temp].description.toString();
      _kategoryController.text = list[temp].kategory.toString();
      // currentDate = DateTime.parse(list[temp].dateOperation.toString());
      _summController.text = list[temp].summ.toString();
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
