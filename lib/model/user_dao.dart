import 'dart:io';

import 'package:Fitness_Community/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDao {
  CollectionReference<UserLocal> getusercollection() {
    var db = FirebaseFirestore.instance;
    var dbDoc = db.collection('user').withConverter<UserLocal>(
          fromFirestore: (snapshot, options) =>
              UserLocal.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
    return dbDoc;
  }

  Future<void> createuser(UserLocal user) {
    var dbDoc = getusercollection();
    return dbDoc.doc(user.id).set(user);
  }

  Future<UserLocal?> getuser(String id) async {
    var doc1 = getusercollection();
    var docSnapShot = await doc1.doc(id).get();
    return docSnapShot.data();
  }

  Future<void> Deleteuser(UserLocal user) {
    var dbDoc = getusercollection();
    return dbDoc.doc(user.id).delete();
  }

  Future<String> UpdateUser(String id, File photo) async {
    var dbDoc = getusercollection();
    var docSnapShot = await dbDoc.doc(id).get();
    UserLocal? user = docSnapShot.data();
    String image = await upload_User_image(photo, id);
    user?.photo = image;
    await dbDoc.doc(id).update(user!.toFireStore());

    return image;
  }

  Future<String> upload_User_image(File file, String userId) async {
    print('ok');
// Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child(userId);
    print(userId);
    await fileRef.putFile(file);
    final snapshot = await fileRef.getDownloadURL();
    return snapshot.toString();
  }
}
