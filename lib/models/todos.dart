class Todos {
  String sId;
  String title;
  String userID;
  String time;
  bool completed;
  String date;
  String content;
  String category;

  Todos(
      {this.sId,
      this.title,
      this.userID,
      this.time,
      this.completed,
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
}