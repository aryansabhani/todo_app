import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper{
  ApiHelper._();
  static final apihelper = ApiHelper._();
  final db = FirebaseFirestore.instance;

  late SharedPreferences preferences;

  Future<Map?> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  setdata({
    required String userId,
  }) async {
    preferences.setString("userId", userId);
  }

  getsetdata() {
    String userId = preferences.getString("userId") ?? '';
    log(userId);
    return userId;
  }



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> signOut() async {
    // setdata(userId: '');
    preferences.remove("userId");


    await GoogleSignIn().signOut(); //For GoogleSignIn
    await FirebaseAuth.instance.signOut();

  }

  createUserWithEmailAndPassword({required String email,required String pass}) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  authStateChanges(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  signInWithEmailAndPassword({required String email,required String pass,}) async {
    try {
      return   await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      // return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }
  getdata(){
    return db.collection("tbl_todo").doc('${getsetdata()}').collection('todos').snapshots();
     }
  addTodo({required String body,required String head,required String date,required String number}) async {
    final city = <String, String>{
      "body": body,
      "head": head,
      "date": date
    };

   await db
        .collection("tbl_todo")
        .doc('${getsetdata()}').collection('todos').doc( number)
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }

  uPDTodo({required String body,required String head,required String date,required String number}) async {
    final city = <String, String>{
      "body": body,
      "head": head,
      "date": date
    };

   await db
        .collection("tbl_todo")
        .doc('${getsetdata()}').collection('todos').doc(number)
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }
  deletetodo({required String number}) async {
    // final city = <String, String>{
    //   "body": body,
    //   "head": head,
    //   "date": date
    // };

   await db
        .collection("tbl_todo")
        .doc('${getsetdata()}').collection('todos').doc(number).delete();
  }
}