import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodaysTaskUI extends StatefulWidget {
  const TodaysTaskUI({Key? key}) : super(key: key);

  @override
  State<TodaysTaskUI> createState() => _TodaysTaskUIState();
}

class _TodaysTaskUIState extends State<TodaysTaskUI> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Container(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Image.network(
                    "https://img.icons8.com/color/2x/user.png",
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "Hello world",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 3,),
              Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1,),

            ],
          ),
        )));
  }
}
