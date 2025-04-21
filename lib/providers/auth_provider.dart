import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI firebaseService;
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  Future<void> signUp(Map<String, dynamic> details,
      String email, String password) async {
    await authService.signUp(details, email, password);
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    String message = await authService.signIn(email, password);
    notifyListeners();
    return(message);
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
