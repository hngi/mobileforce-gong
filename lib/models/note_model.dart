class Notes {
  String sId;

  //sqLite uses integer to represent ID;
  int id;
  String title;
  String description;
  String userID;
  bool important;
  String date;
  String createdAt;
  String updatedAt;
  int iV;
  int backgroundColor;

  Notes.withID(this.id,this.date,this.title,this.description,this.backgroundColor);
  Notes.noID(this.title,this.description,this.date,this.backgroundColor);
  Notes(
      {this.sId,
      this.title,
      this.description,
      this.userID,
      this.important,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Notes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['content'];
    userID = json['userID'];
    important = json['important'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.description;
    data['userID'] = this.userID;
    data['important'] = this.important;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["description"] = description;
    map["backgroundcolor"] = backgroundColor;
    map["date"] = date;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Notes.fromObject(dynamic o) {
    this.id = o["id"];
    this.title = o["title"];
    this.description = o["description"];
    this.date = o["date"];
    this.backgroundColor = o["backgroundcolor"];
  }
}
