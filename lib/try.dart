// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:website/Models.dart';
import 'dart:html' as html;

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  List<Models> models = [];
  List<Models> users = [];
  List<Models> ctlNumber = [];
  List keys = [];
  //TextEditingController datenowcontroller = TextEditingController();
  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController statuscontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  DatabaseReference dref = FirebaseDatabase.instance.ref('Incoming Datas');
  DatabaseReference eref = FirebaseDatabase.instance.ref();
  PlatformFile? selectedfile;
  String? ext;
  final currentDay = DateTime.now().day;
  final currentMonth = DateTime.now().month.toString();
  final currentYear = DateTime.now().year;
  final dateNowFormat = DateFormat('MM-dd-yyyy').format(DateTime.now());
  final sref = FirebaseStorage.instance.ref();
  String? firebaseUrl;
  bool changeColor = false;
  String? status1 = "";

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    } else {
      setState(() {
        selectedfile = result.files.first;
        ext = result.files.first.extension;
       
        // print("File Extension was ${ext}");
      });
    }
  }

  Future uploadFile(String part) async {
    // final result = await FilePicker.platform.pickFiles();
    final path = 'files/${part}.${ext}';
    final bytes = selectedfile!.bytes as Uint8List;
    final ref = FirebaseStorage.instance.ref().child(path);

    if (selectedfile == null) {
      return null;
    } else {
      ref.putData(bytes);
    }
  }

  Future getdownloadLink(Reference ref, String part) async {
    try {
      final url = await ref.getDownloadURL();
      // print(url);
      if (url.isEmpty) {
        return null;
      } else {
        html.window.open(url, '${part}');
      }
    } catch (e) {}

    // setState(() {
    //   firebaseUrl = url;
    //   print(firebaseUrl);
    // });

    //await Dio().download(url.toString(), "Downloads/");
  }

// Future downloadFile(String url) async {

// }

  Future getDataInFirebase() async {
    dref.onValue.listen((event) {

      Map<String, dynamic> dataInFirebase =
          event.snapshot.value as Map<String, dynamic>;
      users = [];
      dataInFirebase.forEach((key, value) {
        final individualData = Models.fromRTDB(value);

        setState(() {
          keys.add(key);
          users.add(Models(
              ctln: individualData.ctln,
              date: individualData.date,
              part: individualData.part,
              agency: individualData.agency,
              datemade: individualData.datemade,
              ext: individualData.ext,
              status: individualData.status,
              remarks: individualData.remarks));
        });
      });
      // setState(() {
      //    users.toSet();
      //    print(users.map((e) => e.part));
      // });

      //print(keys);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int num1;
    final format = DateFormat("MM/dd/yyyy");
    final format1 = DateFormat("yyyy-MM-dd");
    final format2 = DateFormat("yyyy-MM-dd");
    String string = "Upload";
    TextEditingController fileController;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 229, 228),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'INCOMING COMMUNICATIONS ${currentYear}',
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: getDataInFirebase(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 218, 229, 228),
                body: Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 218, 229, 228),
                body: Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            return ListView.builder(
                reverse: false,
                itemCount: users.length,
                itemBuilder: ((context, index) {
                  return DataTable(

                      //  showCheckboxColumn: true,

                      dividerThickness: 1,
                      dataRowHeight: 80,
                      showBottomBorder: true,
                      headingRowHeight: 10,
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Color.fromARGB(255, 113, 198, 191)),
                      columns:
                          //   [
                          //   DataColumn(label: Text('CONTROL NO.'), tooltip: 'CONTROL NO.'),
                          //   DataColumn(label: Text('DATE RECEIVED')),
                          //   DataColumn(label: Text('PARTICULARS')),
                          //   // DataColumn(label: Text('OTM CONTROL NO.')),
                          //   DataColumn(label: Text('AGENCY//OFFICE FROM')),
                          //   DataColumn(label: Text('DATE MADE')),
                          //   DataColumn(label: Text('Remarks')),
                          //   DataColumn(label: Text('')),

                          // ],
                          [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        // DataColumn(label: Text('OTM CONTROL NO.')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('')),
                      ],

                      // ignore: prefer_const_literals_to_create_immutables
                      rows: [
                        DataRow(

                            // ignore: prefer_const_literals_to_create_immutables
                            cells: [
                              DataCell(Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              )),
                              DataCell(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${users[index].ctln}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text("Control Num."),
                                ],
                              )),
                              DataCell(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${users[index].date}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      )),
                                  Text("Date"),
                                ],
                              )),
                              DataCell(SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            // primary: changeColor ? Colors.blue : Colors.pink,
                                            //primary: Colors.blue,
                                            // onSurface: Colors.green,
                                            ),
                                        onPressed: () async {
                                          final ref = sref.child(
                                              'files/${users[index].part}.${users[index].ext}');
                                          getdownloadLink(ref,
                                              "${users[index].part}.${users[index].ext}");
                                          // setState(() {
                                          //   status1 = "Pending...";
                                          // });

                                          /////////////////////////////////////

                                          //////////////////////////////////////////
                                        },
                                        child: Tooltip(
                                            message:
                                                "Click to Download the file",
                                            child: Text("${users[index].part}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: changeColor
                                                      ? Colors.blue
                                                      : Colors.green,

                                                  //color: Color.fromARGB(228, 209, 111, 5)
                                                )))),
                                    Text("Particular"),
                                  ],
                                ),
                              )),
                              DataCell(SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${users[index].agency}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                        )),
                                    Text("agency"),
                                  ],
                                ),
                              )),
                              DataCell(Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${users[index].datemade}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      )),
                                  Text("Date Made")
                                ],
                              )),
                              DataCell(SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: ((BuildContext context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      Text('Status: '),
                                                      Text(
                                                        '${users[index].status}',
                                                        style: TextStyle(
                                                            color: users[index]
                                                                        .status ==
                                                                    'terminated'
                                                                ? Color.fromARGB(
                                                                    255,
                                                                    240,
                                                                    28,
                                                                    28)
                                                                : users[index]
                                                                            .status ==
                                                                        'accomplished'
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            35,
                                                                            240,
                                                                            28)
                                                                    : users[index].status ==
                                                                            'new'
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            10,
                                                                            151,
                                                                            153)
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            240,
                                                                            226,
                                                                            28)),
                                                      ),
                                                    ],
                                                  ),
                                                  content: SizedBox(
                                                    width: 200,
                                                    height: 200,
                                                    child: Text(
                                                        '${users[index].remarks}'),
                                                  ),
                                                );
                                              }));

                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //         builder:
                                          //             (BuildContext context) =>
                                          //                 Try()));
                                        },
                                        child: Text(
                                          "${users[index].status}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: users[index].status ==
                                                      'terminated'
                                                  ? Color.fromARGB(
                                                      255, 240, 28, 28)
                                                  : users[index].status ==
                                                          'accomplished'
                                                      ? Color.fromARGB(
                                                          255, 35, 240, 28)
                                                      : users[index].status ==
                                                              'new'
                                                          ? Color.fromARGB(
                                                              255, 10, 151, 153)
                                                          : Color.fromARGB(255,
                                                              240, 226, 28)),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    ((BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Edit Status'),
                                                    content: SizedBox(
                                                      height: 150,
                                                      width: 100,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                statuscontroller,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'Status'),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return ("This field shouldn't be empty");
                                                              }
                                                            },
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                remarkscontroller,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'Remarks'),
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return ("This field shouldn't be empty");
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            dref
                                                                .child(
                                                                    '${keys[index]}')
                                                                .update({
                                                              'status':
                                                                  statuscontroller
                                                                      .text,
                                                              'remarks':
                                                                  remarkscontroller
                                                                      .text
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                Try()));
                                                          },
                                                          child: Text("Save"))
                                                    ],
                                                  );
                                                }));
                                            // Navigator.of(context)
                                            //     .pushReplacement(
                                            //         MaterialPageRoute(
                                            //             builder: (BuildContext
                                            //                     context) =>
                                            //                 Try()));
                                          },
                                          icon: Icon(Icons.edit))
                                    ],
                                  ))),
                              DataCell(Tooltip(
                                message: "Click to Delete",
                                child: IconButton(
                                    onPressed: () async {
                                      dref.child('${keys[index]}').remove();
                                      sref
                                          .child(
                                              'files/${users[index].part}.${users[index].ext}')
                                          .delete();

                                      const snackBar = SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 210, 111, 36),
                                        content: Text('Successfully Deleted'),
                                        duration: Duration(seconds: 3),
                                      );

                                      // Find the ScaffoldMessenger in the widget tree
                                      // and use it to show a SnackBar.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      CircularProgressIndicator();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              maintainState: false,
                                              builder: (BuildContext context) =>
                                                  Try()));
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                      size: 30,
                                    )),
                              ))
                            ])
                      ]);
                }));

            // Container();
            // return Expanded(

            //   child: ListView.builder(
            //     itemCount: models.length,
            //     itemBuilder:  (context, index) {
            //     return
            //     ListTile(

            //     );
            //   })

            // );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color.fromARGB(255, 218, 229, 228),
                  scrollable: true,
                  title: Text('Add New',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      // TextFormField(
                      //   // controller: emailController,
                      //   decoration: InputDecoration(hintText: 'Particulars'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: partcontroller,
                          decoration: InputDecoration(hintText: 'Particulars'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("This field shouldn't be empty");
                            }
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: agencycontroller,
                          decoration:
                              InputDecoration(hintText: 'Agency/Office from'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("This field shouldn't be empty");
                            }
                          },
                        ),
                      ),
                      // TextFormField(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DateTimeField(
                            validator: (date) {
                              if (date! == null) {
                                return ("This field shouldn't be empty");
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Date Made",
                            ),
                            format: format,
                            controller: datecontroller,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.upload_file,
                                size: 30,
                              ),
                              onPressed: selectFile),
                        ),
                      ),
                      selectedfile == null
                          ? Text('Select a File')
                          : Text(selectedfile!.name),

                      //    controller: emailController,
                      //   decoration: InputDecoration(hintText: 'Date Made'),
                      // ),
                    ]),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          // dref.child('Incoming Datas').remove();

                          // setState(() {
                          //   models.add(Models(ctln: null, date: null, part: partcontroller.text, agency: agencycontroller.text, datemade: datecontroller.text));
                          // });

                          // dref.onValue.listen((event) {
                          //   Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;

                          //   data.forEach((key, value) {
                          //     final abs = Models.ctlnNumber(value);

                          //     ctlNumber.add(abs);

                          //     print(ctlNumber);

                          //    });

                          //  });
                          if (partcontroller.text.isEmpty ||
                              agencycontroller.text.isEmpty ||
                              datecontroller.text.isEmpty ||
                              selectedfile == null) {
                            Navigator.of(context).pop();
                            const snackBar = SnackBar(
                              backgroundColor: Color.fromARGB(255, 210, 48, 36),
                              content: Text(
                                'Please provide ALL the requested Information',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  // letterSpacing: 1,
                                  fontSize: 13,
                                  // fontWeight: FontWeight.w800
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final ctln = DateFormat('ddMM-hhmm-sss')
                                .format(DateTime.now());

                            eref.child('Incoming Datas').push().set({
                              'ctln': ctln,
                              "Particulars": partcontroller.text,
                              "Agency": agencycontroller.text,
                              "DateMade": datecontroller.text,
                              "DateNow": dateNowFormat,
                              //"Url":firebaseUrl
                              "ext": ext,
                              "status": "new",
                              "remarks": ""
                            });
                            await uploadFile(partcontroller.text);


                           // Navigator.pop(context);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Try()));
                          }

                           

                          // await  eref.child('Incoming Datas').push().set({
                          //     "Particulars": partcontroller.text,
                          //     "Agency": agencycontroller.text,
                          //     "DateMade": datecontroller.text
                          //   });

                          // html.window.location.reload();
                          //  setState(() {
                          //    (context as Element).performRebuild();
                          //  });
                        },
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ))
                  ],
                );
              });
        },
        child: const Icon(Icons.add_outlined),
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
      ),
    );
  }
}
