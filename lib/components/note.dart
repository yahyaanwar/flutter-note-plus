class Note {
  int id;
  String _title;
  String _note;
  String _create_date;
  String _update_date;
  String _sort_date;

  Note(this._title, this._note, this._create_date, this._update_date, this._sort_date);

  Note.map(dynamic object) {
    this._title = object['title'];
    this._note = object['note'];
    this._create_date = object['create_date'];
    this._update_date = object['update_date'];
    this._sort_date = object['sort_date'];
  }

  String get title => _title;
  String get note => _note;
  String get createDate => _create_date;
  String get updateDate => _update_date;
  String get sortDate => _sort_date;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = _title;
    map['note'] = _note;
    map['create_date'] = _create_date;
    map['update_date'] = _update_date;
    map['sort_date'] = _sort_date;
    return map;
  }

  void setNoteID(int id) {
    this.id = id;
  }

}