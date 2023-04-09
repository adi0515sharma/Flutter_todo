import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/Utils/Authentication.dart';

import 'Login.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User? user;
  @override
  initState() {
    super.initState();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  loginPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()));
  }

  signOut(){
    Authentication.signOut(context: context);
    loginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            user?.displayName!=null ? Text("User name : ${user?.displayName as String}") : const Text("User name : no user found"),
            user?.email!=null ? Text("Email id : ${user?.email as String}") : const Text("Email id : no email id found"),
            user!=null?
            ElevatedButton(onPressed:() {signOut();}, child: Text("Sign Out"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue))) :
            ElevatedButton(onPressed:() {loginPage();}, child: Text("Sign In"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)))
          ],
        ),
      ),
    );
  }
}
