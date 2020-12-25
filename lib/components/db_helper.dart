import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'dart:io' as io;
import 'dart:async';

import 'package:flutter_boilerplate/components/note.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await setDB();
    return _database;
  }

  toAbsolutePath(path,[base_dir]){
    Path.Context context;
    if(io.Platform.isWindows){
      context = new Path.Context(style:Path.Style.windows);
    }else{
      context = new Path.Context(style:Path.Style.posix);
    }
    base_dir ??= Path.dirname(io.Platform.script.toFilePath());
    path = context.join( base_dir,path);
    return context.normalize(path);
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = toAbsolutePath('SQLiteDB', directory.path);
    final database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database database, int version) async {
    final String sql = 'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, note TEXT, create_date TEXT, update_date TEXT, sort_date TEXT)';
    await database.execute(sql);
    print('DB Created');
  }

  Future <int> saveNote(Note note) async {
    final db_client = await database;
    int res = await db_client.insert('note', note.toMap());
    print('Note created');
    return res;
  }

  Future<List<Note>> getNote() async{
    final db_client = await database;
    List<Map> lists = await db_client.rawQuery('SELECT * FROM note ORDER BY sort_date DESC');
    List<Note> note_data = new List();
    for (final item in lists) {
      final note = Note(item['title'], item['note'], item['create_date'], item['update_date'], item['sort_date']);
      note.setNoteID(item['id']);
      note_data.add(note);
    }
    print('Note fetched');
    return note_data;
  }

  Future <bool> updateNote(Note note) async {
    final db_client = await database;
    int res = await db_client.update('note', note.toMap(), where: "id=?", whereArgs: <int>[note.id]);
    print('Note edited');
    return res > 0;
  }

  Future <int> deleteNote(Note note) async {
    final db_client = await database;
    int res = await db_client.rawDelete("DELETE FROM note WHERE id=?", [note.id]);
    print('Note deleted');
    return res;
  }
}