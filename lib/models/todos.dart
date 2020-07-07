class Todos {
  String sId;

  //sqlite uses int for ID;
  int id;
  String title;
  String userID;
  String time;
  bool isCompleted;

  //sqlite has no boolean and uses int, so I created an Int to represent completed
  int completed;
  String content;
  String date;
  String createdAt;
  String updatedAt;
  int iV;
  int backgroundColor;
  String category;



  Todos.noID(this.date,this.title,this.content,this.isCompleted,this.completed,this.backgroundColor);
  Todos.withID(this.id,this.date,this.title,this.content,this.completed,this.isCompleted,this.backgroundColor);

  Todos(
      {this.sId,
        this.title,
        this.userID,
        this.time,
        this.isCompleted,
        this.date,
        this.category,
        this.content});

  Todos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    userID = json['userID'];
    time = json['time'];
    completed = json['completed'];
    date = json['date'];
    category = json['category'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['userID'] = this.userID;
    data['time'] = this.time;
    data['completed'] = this.completed;
    data['date'] = this.date;
    data['category'] = this.category;
    data['content'] = this.content;
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