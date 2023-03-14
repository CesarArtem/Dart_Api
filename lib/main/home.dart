import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapi/finances.dart';
import 'package:flutterapi/main/finances.dart';
import 'package:flutterapi/main/profile.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final listPage = [
    finances(),
    Profile(),
  ];

  int currentIndex = 0;

  List<Widget> content = [];

  List<String> actionNavigatorList = ['', 'add_user', '', ''];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансы'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Финансы'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Профиль')
        ],
      ),
      body: listPage[currentIndex],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {

  List<String> searchTerms = <String>[];
  List<Finances> list = <Finances>[];

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

        searchTerms.add(finances.number+" "+finances.nameOperation);
        list.add(finances);
      } catch (exception) {
        print(exception);
        break;
      }
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    getList();
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.arrow_back),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     getList();
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     getList();
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     getList();
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}
