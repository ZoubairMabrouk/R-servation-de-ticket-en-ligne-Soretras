import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soretras/Profile.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<Reservation> {
  final DatabaseReference _userRef = FirebaseDatabase.instance.reference();
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late FocusNode textFieldFocusNode1;
  late FocusNode textFieldFocusNode2;
  late FocusNode textFieldFocusNode3;
  late DateTimeRange? calendarSelectedDay;
  late String dropDownValue1 = 'sfax';
  late String dropDownValue2 = 'sfax';
  late bool vis = false;
  late double prix = 0;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textFieldFocusNode1 = FocusNode();
    textFieldFocusNode2 = FocusNode();
    textFieldFocusNode3 = FocusNode();
    dropDownValue1;
    dropDownValue2;
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode3.dispose();
    textFieldFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (textFieldFocusNode1.canRequestFocus ||
              textFieldFocusNode2.canRequestFocus ||
              textFieldFocusNode3.canRequestFocus) {
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Reservation'),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => Profile()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx1c2VyfGVufDB8fHx8MTcwODc4NjExMHww&ixlib=rb-4.0.3&q=80&w=1080',
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Départ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                DropdownButton<String>(
                  value: dropDownValue1,
                  items: <String>[
                    'tunis',
                    'nabeul',
                    'sfax',
                    'mednine',
                    'gafsa',
                    'sousse'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue1 = newValue!;
                    });
                  },
                ),
                Text(
                  'destination',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                DropdownButton<String>(
                  items: <String>[
                    'tunis',
                    'nabeul',
                    'sfax',
                    'mednine',
                    'gafsa',
                    'sousse'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: dropDownValue2,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue2 = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      getData(context);
                    },
                    child: Text('Chercher !'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                Visibility(
                  visible: vis,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),

                      TextField(
                        enabled: false,
                        controller: textController1,
                        focusNode: textFieldFocusNode1,
                        decoration: InputDecoration(
                          labelText: 'jj/mm/aaaa',
                        ),
                      ),
                      // Replace this with your calendar widget
                      SizedBox(height: 20),
                      Text(
                        'Horaire',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),

                      TextField(
                        enabled: false,
                        controller: textController2,
                        focusNode: textFieldFocusNode2,
                        decoration: InputDecoration(
                          labelText: '01:00 am',
                        ),
                      ),
                      Text(
                        'N° de places',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      TextField(
                        controller: textController3,
                        focusNode: textFieldFocusNode3,
                        keyboardType: TextInputType.number,
                      ),

                      Text(
                        'Prix : ' + prix.toString() + ' DT /place',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20, width: 45),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print('Button pressed ...');
                            createTicket(context);
                          },
                          child: Text('Reserver !'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> getData(BuildContext context) async {
    _userRef.child('voyage').onValue.listen((event) {
      Object? data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        // Number exists, now check password
        data.forEach((key, value) {
          if (value['depart'] == dropDownValue1 &&
              value['dest'] == dropDownValue2) {
            vis = true;
            textController1.text = value['date'];
            textController2.text = value['horaire'];
            prix = value['prix'];
          }
        });
      } else {
        // Password does not match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Traget indisponible')),
        );
      }
    });
  }

  Future<void> createTicket(BuildContext context) async {
    int generateRandomNumber() {
      Random random = Random();
      return random.nextInt(9000) + 1000;
    }

    int ref = generateRandomNumber();
    _userRef.child('tickets').push().set({
      'traget': '$dropDownValue1 - $dropDownValue2',
      'ref': ref.toString(),
      'date': textController1.text,
      'nombre de place': textController3.text,
      'latitude': '34',
      'longitude': '12',
      'status': 'Progressing',
    });
    // Password does not match
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resrvation terminer')),
    );
  }
}
