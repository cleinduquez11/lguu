import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/Sample/sample.dart';
import 'package:website/home.dart';

import 'package:website/table.dart';
import 'package:website/try.dart';
import 'package:website/utils/fxn.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Incoming Communications',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Try(),
    
        // Try(),
    
        // Home(),
      ),
    );
  }
}
