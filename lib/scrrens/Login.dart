import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/Utils/Resource.dart';
import 'package:task/scrrens/Registration.dart';

import '../Utils/Authentication.dart';
import '../Utils/utils.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late FToast fToast;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _launchURL()  {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Registration()));
  }

  loginWithEmailAndPassword() async {
    String email = emailController.text;
    String password = passwordController.text;
    Resource<User>? user = await Authentication.loginUserWithEmailAndPassword(email, password);
    if(user!=null){
      if(user.status == ResourceStatus.Success){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()));
      }

      Utils.showToastMessage(user.message, Toast.LENGTH_SHORT);

    }
    else{

      Utils.showToastMessage(Resource.SOMETHING_WENT_WRONG, Toast.LENGTH_SHORT);

    }
  }
  googleLogin(BuildContext context) async{
    Resource<User>? user  = await Authentication.signInWithGoogle(context: context);
    if(user!=null){
      if(user.status == ResourceStatus.Success){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()));
      }
      Utils.showToastMessage(user.message, Toast.LENGTH_SHORT);

    }
    else{

      Utils.showToastMessage(Resource.SOMETHING_WENT_WRONG, Toast.LENGTH_SHORT);

    }
  }

  facebookLogin(BuildContext context) async{
    Resource<User>? user = await Authentication.signInWithFacebook();

    if(user!=null){
      if(user.status == ResourceStatus.Success){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()));
      }

      Utils.showToastMessage(user.message, Toast.LENGTH_SHORT);

    }
    else{

      Utils.showToastMessage(Resource.SOMETHING_WENT_WRONG, Toast.LENGTH_SHORT);

    }
  }
  @override
  initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
        child: SingleChildScrollView(
            child:  Container(
              height: MediaQuery.of(context).size.height,

              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(

                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Text("Sign In", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500,textStyle: TextStyle(fontSize: 23))),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(

                            autovalidateMode: AutovalidateMode.always,
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: "Email Id : ",
                                border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email id';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.always,

                            controller: passwordController,
                            decoration: const InputDecoration(
                                hintText: "Password : ",
                                border: OutlineInputBorder()
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(0, 17, 0,17))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginWithEmailAndPassword();
                          }
                        },
                        child: Center(
                          child: Text("Sign In",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  textStyle: TextStyle(fontSize: 18))),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("--------------"),
                        Text(" OR ", style: GoogleFonts.poppins(color: Colors.black54, fontWeight: FontWeight.w300,textStyle: TextStyle(fontSize: 18))),
                        Text("--------------"),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Try With Socials", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400,textStyle: TextStyle(fontSize: 20))),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(onTap: (){
                              googleLogin(context);
                            },
                            child: Image.asset("images/google.png", width: 35, height: 35, )),
                            SizedBox(width: 20,),
                            GestureDetector(onTap: (){
                              facebookLogin(context);
                            },
                                child: Image.asset("images/facebook.png", width: 35, height: 35))
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "don't have a account ? ", style: TextStyle(color: Colors.black)),

                          TextSpan(text: "SignUp Here", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline), recognizer: TapGestureRecognizer()..onTap = () => _launchURL()),

                        ]
                    ))
                  ],
                ),
              ),
            )))
      );

  }
}
