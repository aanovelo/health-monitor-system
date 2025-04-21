import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/entry_model.dart';
import '../api/firebase_entry_api.dart';

class EntryListProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entryStream;

  EntryListProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntries();
  }

  // getter
  Stream<QuerySnapshot> get entries => _entryStream;

  fetchEntries() {
    _entryStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  void addEntry(Entry item) async {
    String message = await firebaseService.addEntry(item.toJson(item));
    print(message);

    notifyListeners();
  }
}