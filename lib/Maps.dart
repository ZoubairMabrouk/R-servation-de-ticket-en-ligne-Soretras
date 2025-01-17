import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<Maps> {
  final _textController = TextEditingController();
  final _databaseReference = FirebaseDatabase.instance.reference();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map\'s page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter your ticket number',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _launchGoogleMaps();
              },
              child: Text('Open Google Maps'),
            ),
          ],
        ),
      ),
    );
  }

  _launchGoogleMaps() async {
    final ticketNumber = _textController.text;
    final dataSnapshot = await _databaseReference.child('tickets');
    dataSnapshot.onValue.listen((event) async {
      Object? data = event.snapshot.value;
    if (data != null && data is Map<dynamic, dynamic>) {
      if(data.containsKey(ticketNumber)) {
        Map<dynamic, dynamic> userData = data[ticketNumber];
        final latitude = userData['latitude'];
        final longitude = userData['longitude'];

        final url = 'https://www.google.com/maps?q=$latitude,$longitude';
        if (await canLaunch (url)
      ) {
      await launch(url);
      } else {
      throw 'Could not launch $url';
      }
      }} else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ticket number not found.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }});
  }
}
