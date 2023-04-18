import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Resource.dart';
class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }
  static Future<Resource<User>?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    Resource<User>? error;

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {

        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        user = userCredential.user;
        return Resource(ResourceStatus.Success, user, Resource.SUCCESS);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'The account already exists with a different credential.',
          //   ),
          // );
          error = Resource(ResourceStatus.Error, null, Resource.ACCOUNT_EXISTS_WITH_DIFFERENT_PROVIDER);
        } else if (e.code == 'invalid-credential') {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content:
          //     'Error occurred while accessing credentials. Try again.',
          //   ),
          // );
          error = Resource(ResourceStatus.Error, null, Resource.SOMETHING_WENT_WRONG);

        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   Authentication.customSnackBar(
        //     content: 'Error occurred using Google Sign-In. Try again.',
        //   ),
        // );
        error = Resource(ResourceStatus.Error, null, Resource.SOMETHING_WENT_WRONG);
      }
    }

    return error;
  }

  static Future<Resource<void>> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      return Resource(ResourceStatus.Success, null, Resource.SUCCESS);
    } catch (e) {}
    return Resource(ResourceStatus.Error, null, Resource.SOMETHING_WENT_WRONG);
  }
  static Future<Resource<User>?> signInWithFacebook() async {
    // Trigger the sign-in flow
    Resource<User>? error;
    try{
        LoginResult loginResult = await FacebookAuth.instance.login();
        OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken?.token as String);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        return Resource(ResourceStatus.Success, userCredential.user, Resource.SUCCESS);
    }
    catch(e){
      error = Resource(ResourceStatus.Error, null, Resource.SOMETHING_WENT_WRONG);
    }
    return error;
  }

  static Future<Resource<User>?> createUserWithEmailAndPassword(String emailAddress, String password) async{

    Resource<User>? error;
    try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

       return Resource(ResourceStatus.Success, userCredential.user, Resource.SUCCESS);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = Resource(ResourceStatus.Error, null, Resource.WEAK_PASSWORD);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        error = Resource(ResourceStatus.Error, null, Resource.ALREADY_EXISTS);
      }
    } catch (e) {
      error = Resource(ResourceStatus.Error, null, Resource.SOMETHING_WENT_WRONG);
      print(e);
    }

    return error;
  }

  static Future<Resource<User>?> loginUserWithEmailAndPassword(String emailAddress, String password) async{
    Resource<User>? error;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return Resource(ResourceStatus.Success, userCredential.user, Resource.SUCCESS);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = Resource(ResourceStatus.Error, null, Resource.EMAIL_ID_NOT_AVAILABLE);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        error = Resource(ResourceStatus.Error, null, Resource.WRONG_PASSWORD);
      }
    }
    return error;
  }
}