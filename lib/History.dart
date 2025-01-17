import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soretras/Profile.dart';
import 'package:soretras/Resrvation.dart';
import 'package:url_launcher/url_launcher.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History>{
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('tickets');
  List<TicketInfo> ticketInfos = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        ticketInfos.clear();
        data.forEach((key, value) {
          if (value != null) {
            ticketInfos.add(TicketInfo(
              value['traget'] ?? '',
              value['ref'] ?? '',
              value['date'] ?? '',
              value['status'] ?? '',
              value['latitude'] ?? '',
              value['longitude'] ?? '',
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
          title: Text('Tickets'),
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
        body: SafeArea(
          top: true,
          child: ListView.builder(
            itemCount: ticketInfos.length,
            itemBuilder: (context, index) {
              return _buildHistoryRecord(
                context,
                ticketInfos[index].target,
                ticketInfos[index].ref,
                ticketInfos[index].date,
                ticketInfos[index].status,
                ticketInfos[index].latitude,
                ticketInfos[index].longitude,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryRecord(
      BuildContext context,
      String target,
      String ref,
      String date,
      String status,
      String latitude,
      String longitude,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target: $target\nRef: $ref\nDate: $date',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Status: $status',
            style: TextStyle(
              fontFamily: 'Readex Pro',
              color: status == 'Progressing' ? Colors.blue : Colors.red,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(context, 'Edit', () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) => Reservation()),
                );
                // Handle edit action
              }),
              _buildActionButton(context, 'Follow', () {
                _launchGoogleMaps(latitude,longitude);
                // Handle follow action
              }),
              _buildActionButton(context, 'Delete', () {
                // Handle delete action
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      String text,
      void Function() onPressed,
      ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: text == 'Delete' ? Colors.red : Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(100, 40),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Readex Pro',
          color: Colors.white,
          letterSpacing: 0,
        ),
      ),
    );
  }
  _launchGoogleMaps(latitude,longitude) async {
          final String lat = latitude ;
          final String lon = longitude;

          final url = 'https://www.google.com/maps?q=$lat,$lon';
          if (await canLaunch (url)
          ) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }

}

class TicketInfo {
  final String target;
  final String ref;
  final String date;
  final String status;
  final String latitude;
  final String longitude;


  TicketInfo(this.target, this.ref, this.date, this.status,this.latitude,this.longitude);
}
