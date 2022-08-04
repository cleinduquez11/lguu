import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TableWidgetTry extends StatefulWidget {
  const TableWidgetTry({Key? key}) : super(key: key);

  @override
  State<TableWidgetTry> createState() => _TableWidgetTryState();
}

class _TableWidgetTryState extends State<TableWidgetTry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Table(
            border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Center(child: Text("Control Number",style: TextStyle(fontSize: 26),)),
                      Center(child: Text("Date", style: TextStyle(fontSize: 26))),
                      Center(child: Text("Particular",style: TextStyle(fontSize: 26))),
                      Center(child: Text("Agency",style: TextStyle(fontSize: 26))),
                      Center(child: Text("Date Made",style: TextStyle(fontSize: 26))),

                    ]
                  )
                ],

          ),
          Table(
            border: TableBorder.all(),
            
            
                  children: [
                    TableRow(

                      children: [
                         Center(child: Text("",style: TextStyle(fontSize: 26),)),
                      Center(child: Text("", style: TextStyle(fontSize: 26))),
                      Center(child: Text("",style: TextStyle(fontSize: 26))),
                      Center(child: Text("",style: TextStyle(fontSize: 26))),
                      Center(child: Text("",style: TextStyle(fontSize: 26))),

                      ]
                    )
                  ],),
        ],
      ),




    );
    
  }
}