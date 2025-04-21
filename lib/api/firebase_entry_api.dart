import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      await db.collection("entries").add(entry);

      return "Successfully added Entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllEntries() {
    return db.collection("entries").snapshots();
  }

  // Future<String> deleteEntry(String? id) async {
  //   try {
  //     await db.collection("entries").doc(id).delete();

  //     return "Successfully deleted Entry!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> editEntry(String? id, String title) async {
  //   try {
  //     print("New String: $title");
  //     await db.collection("Entrys").doc(id).update({"title": title});

  //     return "Successfully edited Entry!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }

  // Future<String> toggleStatus(String? id, bool status) async {
  //   try {
  //     await db.collection("Entrys").doc(id).update({"completed": status});

  //     return "Successfully edited Entry!";
  //   } on FirebaseException catch (e) {
  //     return "Failed with error '${e.code}: ${e.message}";
  //   }
  // }
}