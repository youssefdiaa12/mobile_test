import 'dart:io';
import 'package:Fitness_Community/model/trainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class UserDao {
  CollectionReference<Trainer> getusercollection() {
    var db = FirebaseFirestore.instance;
    var dbDoc = db.collection('user').withConverter<Trainer>(
      fromFirestore: (snapshot, options) =>
          Trainer.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
    return dbDoc;
  }

  Future<void> createuser(Trainer user,File pdf) async{
    var dbDoc = getusercollection();
    //make the user id=doc.id and then set the user
    var dbref= dbDoc.doc();
    user.id=dbref.id;
    String pdf_path=await upload_User_pdf(pdf, user.id??'');
    user.pdf=pdf_path;
    return dbDoc.doc(user.id).set(user);
  }

  Future<Trainer?> getuser(String id) async {
    var doc1 = getusercollection();
    var docSnapShot = await doc1.doc(id).get();
    return docSnapShot.data();
  }

  Future<void> Deleteuser(Trainer user) {
    var dbDoc = getusercollection();
    return dbDoc.doc(user.id).delete();
  }

  Future<String> UpdateUser(String id,File photo) async{
    var dbDoc = getusercollection();
    var docSnapShot = await dbDoc.doc(id).get();
    Trainer? user=docSnapShot.data();
    String image= await upload_User_pdf(photo, id);
    user?.pdf=image;
    await dbDoc.doc(id).update(user!.toFireStore());

    return image;
  }


  Future<String> upload_User_pdf(
      File file, String userId) async {
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
