import 'package:firebase_auth/firebase_auth.dart';
import 'package:mt_gilead/models/user.dart';
import 'package:mt_gilead/models/settings.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;
  
  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });
}