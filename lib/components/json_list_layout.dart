import 'package:flutter/material.dart';

class JsonListLayout extends StatelessWidget {
  final List data;
  JsonListLayout({this.data});

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
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      color: Colors.orange[50],
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data[index]['date'],
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black45),
                              ),
                              Text(
                                data[index]['title'],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.orange, fontWeight: FontWeight.bold),
                              ),
                              Text(data[index]['body']),
                            ]),
                      ),
                    ));
              })),
    );
  }
}
