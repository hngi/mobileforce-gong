class Note{
  int _id;
  String _title;
  String _description;
  String _date;


  Note (this._title,  this._date, [this._description]);
  Note.withId(this._id, this._title,  this._date, [this._description]);
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title (String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }
  set description (String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;

    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Note.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._date = o["date"];
  }
}