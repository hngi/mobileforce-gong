import 'dart:convert';

class Notes {
  String sId;
  String title;
  String content;
  String userID;
  bool important;
  String date;
  bool uploaded;
  bool shouldUpdate;
  String noteID;

  int id;
  int color;
  int font;

  Notes.withID(this.id,this.date,this.title,this.content,this.color);
  Notes.noID(this.title,this.content,this.date,this.color);
  Notes(
      {this.sId,
      this.title,
      this.content,
      this.userID,
      this.important,
      this.date,
      this.uploaded,
      this.noteID,
        this.color,
        this.font,
      this.shouldUpdate});

  Notes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    userID = json['userID'];
    important = json['important'] == 1 ? true : json['important'] == 0 ? false : json['important'];
    date = json['date'];
    color = json['color'];
    font = json['font'];
    noteID = json['noteID'];
    uploaded = json['uploaded'] == 1 ? true : json['uploaded'] == 0 ? false : json['uploaded'] ?? false;
    shouldUpdate = json['shouldUpdate'] == 1 ? true : json['shouldUpdate'] == 0 ? false : json['shouldUpdate'] ?? false;
    font = json['font'];

  }

  Notes.fromJson2(Map<String, dynamic> json) {
    sId = json['noteID'];
    title = json['title'];
    content = json['content'];
    userID = json['userID'];
    important = json['important'] == 1 ? true : json['important'] == 0 ? false : json['important'];
    date = json['date'];
    color = json['color'];
    font = json['font'];
    uploaded = json['uploaded'] == 1 ? true : json['uploaded'] == 0 ? false : json['uploaded'] ?? false;
    shouldUpdate = json['shouldUpdate'] == 1 ? true : json['shouldUpdate'] == 0 ? false : json['shouldUpdate'] ?? false;
  }

  Map<String, dynamic> toJson() {
    var data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['userID'] = this.userID;
    data['important'] = this.important ? 1 : 0;
    data['date'] = this.date;
    data['color'] = this.color;
    data['font'] = this.font;
    data['uploaded'] = this.uploaded ? 1 : 0;
    data['shouldUpdate'] = this.shouldUpdate ? 1 : 0;
    return data;
  }

}
