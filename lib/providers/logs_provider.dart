import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/logs_model.dart';
import '../api/firebase_logs_api.dart';

class LogListProvider with ChangeNotifier {
  late FirebaseLogAPI firebaseService;
  late Stream<QuerySnapshot> _logStream;

  LogListProvider() {
    firebaseService = FirebaseLogAPI();
    fetchLogs();
  }

  // getter
  Stream<QuerySnapshot> get logs => _logStream;

  fetchLogs() {
    _logStream = firebaseService.getAllLogs();
    notifyListeners();
  }

  void addLog(Log item) async {
    String message = await firebaseService.addLog(item.toJson(item));
    print(message);

    notifyListeners();
  }
}