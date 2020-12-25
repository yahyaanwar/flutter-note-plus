import 'package:flutter/material.dart';

class ListViewLayout extends StatelessWidget {
  final List<String> data;
  ListViewLayout({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        leading: Icon(Icons.home),
        title: Center(
            child: Column(
          children: <Widget>[
            Text("Yahya Anwar Ramadhan"),
            Text(
              "17.1.03.02.0006",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        )),
        actions: <Widget>[Icon(Icons.favorite)],
      ),
      body: new Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('${data[index]}'),
                );
              })),
    );
  }
}
