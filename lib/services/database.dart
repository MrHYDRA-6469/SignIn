import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference dataCollection =
      Firestore.instance.collection('Data');

  // ignore: non_constant_identifier_names
  Future<void> updateUserData(
      String email, String password, int plytime) async {
    return await dataCollection.document(uid).setData({
      'Email': email,
      'Password': password,
      'Playing Hours': plytime,
    });
  }
}
