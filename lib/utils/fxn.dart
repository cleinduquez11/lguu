import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Models.dart';


class DataProvider with ChangeNotifier {


  static List<Models> data = [];

  DatabaseReference dref = FirebaseDatabase.instance.ref('Incoming Datas');



  Future fetchData() async {



      dref.onValue.listen((event) {
      Map<String, dynamic> dataInFirebase =
          event.snapshot.value as Map<String, dynamic>;

      dataInFirebase.forEach((key, value) {
        final individualData = Models.fromRTDB(value);

      
          data.add(Models(
              ctln: individualData.ctln,
              date: individualData.date,
              part: individualData.part,
              agency: individualData.agency,
              datemade: individualData.datemade,
              ext: individualData.ext,
              status: individualData.status,
              remarks: individualData.remarks));
         notifyListeners();
      });
    });


     
    
    
  }





  // Future updateData(String id, String title) async {
  //   try {
      
  //     notifyListeners();
  //   } catch (e) {
  //     throw (e);
  //   }
  // }

  List<Models> get getData {
    return data;
  
}
}