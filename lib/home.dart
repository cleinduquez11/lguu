// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:website/Models.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Models> models = [];
  //TextEditingController datenowcontroller = TextEditingController();
  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  DatabaseReference dref = FirebaseDatabase.instance.ref('Incoming Datas');
  DatabaseReference eref = FirebaseDatabase.instance.ref();
  PlatformFile? selectedfile;
  final currentDay = DateTime.now().day;
  final currentMonth = DateTime.now().month.toString();
  final currentYear = DateTime.now().year;
  final dateNowFormat = DateFormat('MM-dd-yyyy').format(DateTime.now());

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
    } else {
      setState(() {
        selectedfile = result.files.first;
      });
    }
  }

  Future uploadFile(String part) async {
    // final result = await FilePicker.platform.pickFiles();
    final path = 'files/${part}';
    final bytes = selectedfile!.bytes as Uint8List;
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putData(bytes);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'INCOMING COMMUNICATIONS ${currentYear}',
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
          stream: dref.onValue,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              // setState(() {
              //   models.clear();
              // });

              // DataSnapshot dataValues = snapshot.data! as DataSnapshot;
              // Map <String, dynamic> values = dataValues.value as Map<String, dynamic>;
              Map<String, dynamic> myOrders = Map.from(
                  (snapshot.data! as DatabaseEvent).snapshot.value
                      as Map<String, dynamic>);

              myOrders.forEach((key, value) {
                // final nextOrder = Map.from(value);
                final nextOrder = Models.fromRTDB(value);

                models.add(Models(
                    ctln: nextOrder.ctln,
                    date: nextOrder.date,
                    part: nextOrder.part,
                    agency: nextOrder.agency,
                    datemade: nextOrder.datemade,
                    ext: nextOrder.ext,
                    status: nextOrder.status,
                    remarks: nextOrder.remarks));

                // Models modell = Models(null, null, nextOrder["Particulars"], nextOrder["Agency"], nextOrder["DateMade"]);

                //models.add(nextOrder.values)
                // final ordertile = ListTile(
                //   title: Text(nextOrder['Particulars']),
                //   subtitle: Text(nextOrder["Agency"]),
                // );
                // li.add(ordertile);
              });
            } else {
              return Center(
                child: Container(
                    child: Text(
                  'There is no Incoming Communication',
                  style: TextStyle(fontSize: 38, color: Colors.blueAccent),
                )),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Container(
                    child: Text(
                  'Connection Error',
                  style: TextStyle(fontSize: 38, color: Colors.pink),
                )),
              );
            }

            // return
            // DataTable(
            // columns: _createColumns(),
            // rows: [
            //   DataRow(cells: [

            //     DataCell( Text("${models[index].ctln}")),
            //             DataCell(Text("${models[index].date}")),
            //             DataCell(Text("${models[index].part}")),
            //             DataCell( Text("${models[index].agency}")),
            //             DataCell(Text("${models[index].datemade}")),

            //   ])
            // ]

            // );
            return ListView.builder(
                reverse: false,
                itemCount: models.length,
                itemBuilder: ((context, index) {
                  return DataTable(
                      //  showCheckboxColumn: true,

                      dividerThickness: 1,
                      dataRowHeight: 80,
                      showBottomBorder: true,
                      //headingRowHeight: 10,
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Color.fromARGB(255, 9, 136, 100)),
                      columns: [
                        DataColumn(
                            label: Text('CONTROL NO.'), tooltip: 'CONTROL NO.'),
                        DataColumn(label: Text('DATE RECEIVED')),
                        DataColumn(label: Text('PARTICULARS')),
                        // DataColumn(label: Text('OTM CONTROL NO.')),
                        DataColumn(label: Text('AGENCY//OFFICE FROM')),
                        DataColumn(label: Text('DATE MADE')),
                      ],
                      // [
                      //   DataColumn(label: Text('')),
                      //   DataColumn(label: Text('')),
                      //   DataColumn(label: Text('')),
                      //   // DataColumn(label: Text('OTM CONTROL NO.')),
                      //   DataColumn(label: Text('')),
                      //   DataColumn(label: Text('')),
                      // ],

                      // ignore: prefer_const_literals_to_create_immutables
                      rows: [
                        DataRow(

                            // ignore: prefer_const_literals_to_create_immutables
                            cells: [
                              DataCell(Text("${models[index].ctln}")),
                              DataCell(Text("${models[index].date}")),
                              DataCell(TextButton(
                                  onPressed: () {},
                                  child: Text("${models[index].part}"))),
                              DataCell(Text("${models[index].agency}")),
                              DataCell(Text("${models[index].datemade}")),
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
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Add New'),
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
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: agencycontroller,
                          decoration:
                              InputDecoration(hintText: 'Agency/Office from'),
                        ),
                      ),
                      // TextFormField(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DateTimeField(
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

                          await eref.child('Incoming Datas').push().set({
                            "Particulars": partcontroller.text,
                            "Agency": agencycontroller.text,
                            "DateMade": datecontroller.text,
                            "DateNow": dateNowFormat,
                          });
                          await uploadFile(partcontroller.text);
                          Navigator.pop(context);

                          // await  eref.child('Incoming Datas').push().set({
                          //     "Particulars": partcontroller.text,
                          //     "Agency": agencycontroller.text,
                          //     "DateMade": datecontroller.text
                          //   });

                          //  html.window.location.reload();
                          //  setState(() {
                          //    (context as Element).performRebuild();
                          //  });

                          //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Home()));
                        },
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
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

DataTable _createDataTable() {
  return DataTable(
    columns: _createColumns(),
    rows: _createRows(),
    dividerThickness: 5,
    dataRowHeight: 80,
    showBottomBorder: true,
    headingTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headingRowColor:
        MaterialStateProperty.resolveWith((states) => Colors.black),
  );
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('CONTROL NO.'), tooltip: 'CONTROL NO.'),
    DataColumn(label: Text('DATE RECEIVED')),
    DataColumn(label: Text('PARTICULARS')),
    DataColumn(label: Text('OTM CONTROL NO.')),
    DataColumn(label: Text('AGENCY//OFFICE FROM')),
    DataColumn(label: Text('DATE MADE')),
  ];
}

List<DataRow> _createRows() {
  return [
    DataRow(cells: [
      DataCell(Text('2022-02-025')),
      DataCell(Text(
        '2/2/2022',
      )),
      DataCell(
          Text('Letter of Invitation for Demonstration and Virtual Meeting')),
      DataCell(Text('')),
      DataCell(Text('The clean 02 eco-friendly Corporation')),
      DataCell(Text('1/25/2022')),
    ]),
    DataRow(cells: [
      DataCell(Text('2022-02-026')),
      DataCell(Text(
        '2/2/2022',
      )),
      DataCell(
          Text('Request for a copy of the Comprehensive Land use Plan-Clup')),
      DataCell(Text('')),
      DataCell(Text('Engineering Students')),
      DataCell(Text('1/26/2022')),
    ])
  ];
}
