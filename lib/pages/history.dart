import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key, this.user_id});
  final user_id;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('poids')
            .where('user_id', isEqualTo: widget.user_id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return Text('Aucun Poids');
          }

          List<dynamic> poids = [];
          snapshot.data!.docs.forEach((element) {
            poids.add(element);
          });
          return ListView.builder(
              itemCount: poids.length,
              itemBuilder: (context, index) {
                final poid = poids[index];
                final weight = poid['poid'].toString();
                final timestamp = poid['date'];
                final String date = DateFormat.yMd().format(timestamp.toDate());

                return Card(
                  child: ListTile(
                    leading: Icon(Icons.monitor_weight_outlined),
                    title: Text("$date"),
                    subtitle: Text(weight),
                  ),
                );
              });
        },
      ),
    );
  }
}
