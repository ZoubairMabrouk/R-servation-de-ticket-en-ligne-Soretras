import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soretras/Profile.dart';
import 'package:soretras/Resrvation.dart';

class Voyage {
  final String depart;
  final String destination;
  final String horair;
  final String place;

  Voyage(this.depart, this.destination, this.horair, this.place);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('voyage');
  List<Voyage> voyages = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        voyages.clear();
        data.forEach((key, value) {
          if (value != null) {
            voyages.add(Voyage(
              value['depart'] ?? '',
              value['dest'] ?? '',
              value['horaire'] ?? '',
              value['place'] ?? '',
            ));
          }
        });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/sntri.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'Soretras',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => Profile()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx1c2VyfGVufDB8fHx8MTcwODc4NjExMHww&ixlib=rb-4.0.3&q=80&w=1080',
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: voyages.length,
            itemBuilder: (context, index) {
              return buildContainer(
                context,
                voyages[index].depart,
                voyages[index].destination,
                voyages[index].horair,
                voyages[index].place,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildContainer(BuildContext context, String depart, String destination,
      String horair, String place) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/sntri.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$depart - $destination',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '$horair',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '$place',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 18,
                      color: place == 'dispo' ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => Reservation()),
                );
              },
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 24,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
