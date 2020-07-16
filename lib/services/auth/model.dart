class Users {
  String name;
  String uid;
  String photoUrl;
  String email;

  Users({this.email, this.name, this.photoUrl, this.uid});

  Users.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    photoUrl = data['photoUrl'];
    uid = data['uid'];
    name = data['username'];
  }
}