import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          height: 400,
          width: 400,
          child: CircularProgressIndicator(),

        ),
      ),

    );
    
  }
}