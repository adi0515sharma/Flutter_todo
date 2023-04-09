import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/Utils/Authentication.dart';

import 'Home.dart';
import 'Login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  initState() {
    super.initState();
    // Add listeners to this class
    print("registration page called");
  }

  _launchURL() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  final _formKey = GlobalKey<FormState>();


  regiseterWithEmailAndPassword() async{
    String email = emailController.text;
    String password = passwordController.text;
    UserCredential? user = await Authentication.createUserWithEmailAndPassword(email, password);
    if(user!=null)
    {
      Fluttertoast.showToast(
          msg: "Register successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Home()));
    }
    else{
      Fluttertoast.showToast(
          msg: "Couldn't able to register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Sign Up",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      textStyle: TextStyle(fontSize: 23))),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: "Email Id : ", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: "Password : ", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Confirm Password : ",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      }
                      return null;
                    },
                  ),
                ],
              )),

              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(0, 17, 0,17))),
                  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regiseterWithEmailAndPassword();
                      }
                  },
                  child: Center(
                    child: Text("Sign Up",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(fontSize: 18))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "already have account ? ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "SignIn here",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL();
                    },
                ),
              ]))
            ],
          ),
        ),
      )),
    );
  }
}
