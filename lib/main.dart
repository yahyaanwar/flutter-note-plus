// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:async';
// import 'dart:convert';
// import './components/json_list_layout.dart';
// import './components/list_view_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/pages/note_page.dart';
import 'package:flutter_boilerplate/components/db_helper.dart';
import 'package:flutter_boilerplate/components/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final database = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => NotePage(null, true)),
              )),
      appBar: AppBar(
        title: Text('Note +'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: database.getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          final data = snapshot.data;
          return snapshot.hasData
              ? NoteList(data)
              : Center(child: Text('Tidak Ada Data'));
        },
      ),
    );
  }
}

// class JsonWidget extends StatefulWidget {
//   @override
//   _JsonWidgetState createState() => _JsonWidgetState();
// }

// class _JsonWidgetState extends State<JsonWidget> {
//   List data;

//   Future<String> get_data() async {
//     // http.Response raw = await http.get(
//     //   Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'), headers: {
//     //     'Accept': 'application/json'
//     //   }
//     // );

//     // Source: https://api.spacexdata.com/v4/history
//     String jsonString = await rootBundle.loadString('json/news.json');

//     this.setState(() {
//       data = json.decode(jsonString);
//     });
//   }

//   @override
//   void initState() {
//     this.get_data();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return JsonListLayout(data: data,);
//   }
// }
