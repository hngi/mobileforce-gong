class Notes {
  String sId;
  String title;
  String content;
  String userID;
  bool important;
  String date;

  Notes(
      {this.sId,
      this.title,
      this.content,
      this.userID,
      this.important,
      this.date});

  Notes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    userID = json['userID'];
    important = json['important'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['userID'] = this.userID;
    data['important'] = this.important;
    data['date'] = this.date;
    return data;
  }
}
