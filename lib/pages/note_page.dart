import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/components/note.dart';
import 'package:flutter_boilerplate/components/db_helper.dart';

class NotePage extends StatefulWidget {
  final Note _note;
  final bool _is_new;

  NotePage(this._note, this._is_new);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title;
  Note note;
  bool _can_edit = true;

  final title_controller = TextEditingController();
  final note_controller = TextEditingController();

  final now = DateTime.now();

  Future addRecord() async {
    final db = DBHelper();
    String date_now =
        '${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}';
    final new_note = Note(title_controller.text, note_controller.text, date_now,
        date_now, now.toString());
    await db.saveNote(new_note);
    print('saved');
  }

  Future saveRecord() async {
    final db = DBHelper();
    String date_now =
        '${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}';
    final edit_note = Note(title_controller.text, note_controller.text,
        note.createDate, date_now, now.toString());
    edit_note.setNoteID(this.note.id);
    await db.updateNote(edit_note);
    print('saved');
  }

  void _saveData() {
    if (widget._is_new) {
      addRecord();
    } else {
      saveRecord();
    }
    Navigator.of(context).pop();
  }

  void _editData() {
    setState(() {
      _can_edit = true;
      title = 'Edit Note';
    });
  }

  Future _deleteRecord() async {
    final db = DBHelper();
    await db.deleteNote(this.note);
    print('deleted');
  }

  void _confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Are you sure?",
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
            _deleteRecord();
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Text("Delete"),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          child: Text("Cancel"),
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    if (widget._note != null) {
      note = widget._note;
      title_controller.text = note.title;
      note_controller.text = note.note;
      title = 'Open Note';
      _can_edit = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._is_new) {
      title = 'New Note';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: null,
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            readOnly: !_can_edit,
            controller: title_controller,
            decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24.0, color: Colors.white60),
                border: InputBorder.none),
            style: TextStyle(fontSize: 24.0, color: Colors.white),
            maxLines: 1,
            keyboardType: TextInputType.text,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              readOnly: !_can_edit,
              controller: note_controller,
              decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white60),
                  border: InputBorder.none),
              style: TextStyle(fontSize: 18.0, color: Colors.white),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CreateButton(
                  icon: Icons.save,
                  enable: _can_edit,
                  onpress: _saveData,
                ),
                CreateButton(
                  icon: Icons.edit,
                  enable: !_can_edit,
                  onpress: _editData,
                ),
                CreateButton(
                  icon: Icons.delete,
                  enable: !widget._is_new,
                  onpress: _confirmDelete,
                ),
              ],
            ))
      ]),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  CreateButton({this.icon, this.enable, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enable ? Colors.white : Colors.white38),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 18.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}
