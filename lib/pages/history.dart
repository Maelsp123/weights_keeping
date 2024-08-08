import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Poids',
                hintText: 'Entrez votre poids',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre';
                }
                if (int.tryParse(value) == null) {
                  return 'Veuillez entrer un poids valide';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Envoyer"),
            ),
          ),
        ],
      )),
    );
  }
}
