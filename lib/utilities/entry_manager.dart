import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntryManager {
  static User? cur_user;
  static final db = FirebaseFirestore.instance;
  static int birthyear = 0;

  static start() async {
    if (FirebaseAuth.instance.currentUser != null) {
      cur_user = FirebaseAuth.instance.currentUser!;

      birthyear = await get_data_doc("", "birthyear");
    }
  }

  static set_user(String fullName, int birthyear) {
    CollectionReference users = db.collection('users');
    users
        .doc(cur_user?.uid)
        .set({'full_name': fullName, 'birthyear': birthyear})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static add_entry(String title, DateTime date, int length) async {
    CollectionReference years = db.collection('users').doc(cur_user?.uid).collection("years");

    years.doc((date.year - birthyear).toString()).set({
      date.month.toString(): {
        date.day.toString(): {"title": title, "length": length}
      }
    }, SetOptions(merge: true));
  }

  static get_data_doc(String path, String param, [bool get_from_cache = true]) async {
    return await db
        .collection('users')
        .doc("${cur_user?.uid}$path")
        .get(GetOptions(source: get_from_cache ? Source.cache : Source.server))
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return param.isEmpty ? data : data[param];
      } else {
        return 0;
      }
    }).catchError((error) {
      print("Pulling data from server");
      return get_data_doc(path, param, false);
    });
  }

  static get_year(int year) async {
    final x = await get_data_doc('/years/$year', "");

    return x;
  }
}
