


import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class Database{

DatabaseReference? dref;


Database(this.dref);


static void getRef(DatabaseReference ref){

  ref =  FirebaseDatabase.instance.ref();
}




}