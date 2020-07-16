import 'dart:io';
import '../auth/userState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../auth/model.dart';

Firestore  _firestore = Firestore.instance;

Future<bool> addProfilePicture(String uid, File photo) async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  // final DocumentReference _documentReference =
  //   _firestore.collection('userData').document(uid).collection('profile').document();

  var _timeKey = new DateTime.now();
  final StorageReference _postpicRef =
      FirebaseStorage.instance.ref().child('Profile pics');
  final StorageUploadTask _uploadTasks =
      _postpicRef.child(_timeKey.toString() + "jpg").putFile(photo);
  var _imageUrl = await (await _uploadTasks.onComplete).ref.getDownloadURL();
  String _url = _imageUrl.toString();

  // _documentReference.updateData(
  //   {
  //     'photoUrl' : _url
  //   }
  // );
  _firestore
      .collection('userData')
      .where('uid', isEqualTo: uid)
      .getDocuments()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((DocumentSnapshot documentSnapshot) {
      documentSnapshot.reference.updateData({'photoUrl': _url}).catchError((e) {
        print(e);
      });
    });
  }).catchError((e) {
    print(e);
  });
  var userUpdateInfo = UserUpdateInfo();
  userUpdateInfo.photoUrl = _url;
  user.updateProfile(userUpdateInfo).catchError((e) {
    print(e);
  });

  await _firestore
      .collection('posts')
      .where('userId', isEqualTo: uid)
      .getDocuments()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((DocumentSnapshot documentSnapshot) {
      documentSnapshot.reference
          .updateData({'profilePic': _url}).catchError((e) {
        print(e);
      });
    });
  }).catchError((e) {
    print(e);
  });

  print('update success');
  return user != null;
}


Future<void> updateProfile(
    String uid, String username) async {
  _firestore
      .collection('userData')
      .where('uid', isEqualTo: uid)
      .getDocuments()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((DocumentSnapshot documentSnapshot) {
      documentSnapshot.reference.updateData({
        'username': username,
      }).catchError((e) {
        print(e);
      });
    });
  }).catchError((e) {
    print(e);
  });
}

getUsersData(UserNotifier userNotifier, String uid) async {
  DocumentSnapshot snapshot = await _firestore
      .collection('userData')
      .document(uid).get();
      

  List<Users> _usersList = [Users(
    email : snapshot['email'],
    photoUrl : snapshot['photoUrl'],
    uid : snapshot['uid'],
    name : snapshot['username']
  )];

  userNotifier.userProfileData = _usersList;
}
