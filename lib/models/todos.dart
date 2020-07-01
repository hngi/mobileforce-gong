class Todos {
  String sId;
  String title;
  String userID;
  String time;
  bool completed;
  String date;
  String createdAt;
  String updatedAt;
  int iV;

  Todos(
      {this.sId,
      this.title,
      this.userID,
      this.time,
      this.completed,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Todos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    userID = json['userID'];
    time = json['time'];
    completed = json['completed'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['userID'] = this.userID;
    data['time'] = this.time;
    data['completed'] = this.completed;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}