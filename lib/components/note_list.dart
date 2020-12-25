import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/components/note.dart';
import 'package:flutter_boilerplate/pages/note_page.dart';

class NoteList extends StatefulWidget {
  final List<Note> note;
  NoteList(this.note, {Key key});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3),
        itemCount: widget.note.length == null ? 0 : widget.note.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => NotePage(widget.note[i], false)));
              },
              child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.note[i].title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.all(8.0),
                        width: double.infinity,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  widget.note[i].note,
                                  style: TextStyle(fontSize: 16.0),
                                ))),
                      ),
                      Divider(color: Colors.grey),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          'Created at ${widget.note[i].createDate}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          'Updated at ${widget.note[i].updateDate}',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ]),
              ));
        });
  }
}
