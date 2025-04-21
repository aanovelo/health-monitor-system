import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLogAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addLog(Map<String, dynamic> log) async {
    try {
      await db.collection("logs").add(log);

      return "Successfully added Log!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllLogs() {
    return db.collection("logs").snapshots();
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