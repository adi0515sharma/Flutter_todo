
import 'package:flutter/material.dart';

class TaskUI extends StatefulWidget {
  const TaskUI({Key? key}) : super(key: key);

  @override
  State<TaskUI> createState() => _TaskUIState();
}

class _TaskUIState extends State<TaskUI> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(2, 4, 2, 4),
            child: Image.asset('images/google.png', width: 30, height: 30,)),

        Padding(padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("title"),
                    Text("date")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("title"),
                    Text("date")
                  ],
                )
              ],
            )
        )

      ],
    );
  }
}

