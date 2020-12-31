import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(
      String email, String password, String name, String age) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'age': age,
      'password': password,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        age: snapshot.data['age']);
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
