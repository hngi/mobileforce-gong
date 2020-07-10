class Todos {
  String sId;
  String title;
  String userID;
  String time;
  bool completed;
  String date;
  String content;
  String category;
  bool uploaded;
  bool shouldUpdate;

  //sqlite uses int for ID;
  int id;
  bool isCompleted;

  //sqlite has no boolean and uses int, so I created an Int to represent completed
  int backgroundColor;



  Todos.noID(this.date,this.title,this.content,this.isCompleted,this.completed,this.backgroundColor);
  Todos.withID(this.id,this.date,this.title,this.content,this.completed,this.isCompleted,this.backgroundColor);

  Todos(
      {this.sId,
      this.title,
      this.userID,
      this.time,
      this.completed,
      this.date,
      this.category,
      this.content,
      this.uploaded,
      this.shouldUpdate});

  Todos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    userID = json['userID'];
    time = json['time'];
    completed = json['completed'] == 1 ? true : json['completed'] == 0 ? false : json['completed'];
    date = json['date'];
    category = json['category'];
    content = json['content'];
    uploaded = json['uploaded'] == 1 ? true : json['uploaded'] == 0 ? false : json['uploaded'] ?? true;
    shouldUpdate = json['shouldUpdate'] == 1 ? true : json['shouldUpdate'] == 0 ? false : json['shouldUpdate'] ?? true;
  }

  Todos.fromJson2(Map<String, dynamic> json) {
    sId = json['todoID'];
    title = json['title'];
    userID = json['userID'];
    time = json['time'];
    completed = json['completed'] == 1 ? true : json['completed'] == 0 ? false : json['completed'];
    date = json['date'];
    category = json['category'];
    content = json['content'];
    uploaded = json['uploaded'] == 1 ? true : json['uploaded'] == 0 ? false : json['uploaded'] ?? true;
    shouldUpdate = json['shouldUpdate'] == 1 ? true : json['shouldUpdate'] == 0 ? false : json['shouldUpdate'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['userID'] = this.userID;
    data['time'] = this.time;
    data['completed'] = this.completed ? 1 : 0;
    data['date'] = this.date;
    data['category'] = this.category;
    data['content'] = this.content;
    data['uploaded'] = this.uploaded ? 1 : 0;
    data['shouldUpdate'] = this.shouldUpdate ? 1 : 0;
    return data;
  }




  Todos.fromObject(dynamic o) {
    this.id = o["id"];
    this.time = o["time"];
    this.title = o["title"];
    this.date = o["date"];
    this.backgroundColor = o["backgroundcolor"];
    this.completed = o["completed"];
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["completed"] = completed;
    map["date"] = date;
    map["backgroundcolor"] = backgroundColor;
    map["time"] = time;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}