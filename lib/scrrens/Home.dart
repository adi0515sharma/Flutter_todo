import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/Authentication.dart';
import '../Utils/Resource.dart';
import '../Utils/utils.dart';
import '../components/Task.dart';
import '../components/TodaysTaskUI.dart';
import 'Login.dart';
import '../Utils/AppBarDelegate.dart';

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

  loginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  signOut() async {
    Resource<void> response = await Authentication.signOut(context: context);
    if (response != null && response.status != null) {
      Utils.showToastMessage(response.message, Toast.LENGTH_SHORT);
    } else {
      Utils.showToastMessage(Resource.SOMETHING_WENT_WRONG, Toast.LENGTH_SHORT);
    }
    loginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: 70,
          toolbarHeight: 50,
          elevation: 10,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            child: Image.network(
                                'https://img.icons8.com/color/2x/user.png'),
                            backgroundColor: Colors.white,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              height: 70,
              color: Colors.white60,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Search here",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    // Perform search operation here
                                  },
                                ),
                                hintStyle: TextStyle(color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          )))
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          expandedHeight: 155,
          pinned: true,
          snap: false,
          floating: false,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Today's task",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 110,
                  child: PageView(
                    children: <Widget>[TodaysTaskUI(),TodaysTaskUI()],
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),

        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              TaskUI(),
              TaskUI(),
              TaskUI(),
              TaskUI(),
            ],
          )
        ]))
      ],
    )));
  }
}
