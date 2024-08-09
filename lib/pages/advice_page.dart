import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('advices').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucun conseil disponible.'));
          }

          final conseils = snapshot.data!.docs;

          return ListView.builder(
            itemCount: conseils.length,
            itemBuilder: (context, index) {
              final conseil = conseils[index];
              final label = conseil['label'] as String;
              final desc = conseil['desc'] as String;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(desc),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
