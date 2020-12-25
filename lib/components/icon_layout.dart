import 'package:flutter/material.dart';

class IconLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_up,
                  size: 90,
                  color: Colors.amber[400],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_left,
                  size: 90,
                  color: Colors.amber[400],
                ),
                Icon(
                  Icons.circle,
                  size: 90,
                  color: Colors.amber[800],
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 90,
                  color: Colors.amber[400],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 90,
                  color: Colors.amber[400],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
