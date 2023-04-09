import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/scrrens/Home.dart';
import 'package:task/scrrens/Registration.dart';
import 'Utils/Authentication.dart';
import 'scrrens/Login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Authentication.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget checkCurrentUser(){
    if(FirebaseAuth.instance.currentUser!=null){
       return Home();
    }
    return Login();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: checkCurrentUser(),
      ),
    );
  }
}

