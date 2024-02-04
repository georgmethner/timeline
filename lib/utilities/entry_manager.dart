
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntryManager {
  static User cur_user = FirebaseAuth.instance.currentUser!;

  static set_user(String fullName, int birthyear) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(cur_user.uid)
        .set({'full_name': fullName, 'birthyear': birthyear})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //static add_entry(String title, DateTime date, int length) async {
  //  CollectionReference months =
  //      FirebaseFirestore.instance.collection('users').doc(cur_user.uid).collection("months");
//
  //  int birthyear = await get_data("", "birthyear");
  //  int month_index = ((date.year - birthyear) * 12) + date.month - 1;
//
  //  months.doc(month_index.toString()).collection("entries").doc(title)
  //      .set({"day": date.day, 'length': length});
  //}

  static add_entry(String title, DateTime date, int length) async {
    CollectionReference years =
        FirebaseFirestore.instance.collection('users').doc(cur_user.uid).collection("years");

    int birthyear = await get_data_doc("", "birthyear");

    years.doc((date.year - birthyear).toString()).set({
      date.month.toString(): {
        date.day.toString(): {"title": title, "length": length}
      }
    }, SetOptions(merge: true));
  }

  static get_data_doc(String path, String param) async {
    return await FirebaseFirestore.instance
        .collection('users').doc("${cur_user.uid}$path")
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return param.isEmpty ? data : data[param];
      // ...
    });
  }

  static get_data_col(String path, String param) async {
    return await FirebaseFirestore.instance
        .collection('users/${cur_user.uid}$path').get();
  }

  static get_year(int year) async {
    final x = await get_data_doc('/years/$year', "");

    print(x);
    return x;
  }
}
