import 'package:flutter/material.dart';

import '../components/bar_graph.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List weights;
  final user_id;

  const HomePage({
    super.key,
    required this.weights,
    this.user_id,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Text(
                "Today",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    child: Image.asset(
                      'assets/images/weight.jpg',
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Text(" Poids"),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Text("Date"),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showAddWeightPopup(context, widget.user_id);
                            },
                            icon: Icon(
                              Icons.new_label,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.mode,
                              size: 30,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Text(
                "Stats",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 200,
              child: BarGraph(
                weeklySummary: widget.weights,
              ),
            ),
            Container(
              child: Text(
                "Conseils",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(5),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "Mangez une variété d'aliments riches en nutriments, y compris des fruits, des légumes, des protéines maigres, des grains entiers, et des graisses saines. Évitez les aliments transformés et riches en sucre."),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(5),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "L'activité physique aide à brûler des calories, à renforcer les muscles et à améliorer le bien-être général. Essayez de combiner des exercices cardiovasculaires (comme la marche, la course, ou le vélo) avec des exercices de renforcement musculaire."),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddWeightPopup extends StatefulWidget {
  final String userId;

  const AddWeightPopup({super.key, required this.userId});

  @override
  State<AddWeightPopup> createState() => _AddWeightPopupState();
}

class _AddWeightPopupState extends State<AddWeightPopup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController poidsController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    poidsController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final poids = double.parse(poidsController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enregistrement...")));

      CollectionReference poidsRef =
          FirebaseFirestore.instance.collection('poids');
      await poidsRef
          .add({'date': selectedDate, 'poid': poids, 'user_id': widget.userId});

      Navigator.of(context).pop(); // Fermer le pop-up après l'enregistrement
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ajouter un Poids"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Poids',
                  hintText: 'Entrez votre poids',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nombre';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un poids valide';
                  }
                  if (double.parse(value) < 5 || double.parse(value) > 200) {
                    return 'Veuillez entrer un poids valide';
                  }
                  return null;
                },
                controller: poidsController,
              ),
              SizedBox(height: 10),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Entrez la Date',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 0)),
                initialPickerDateTime: DateTime.now(),
                onChanged: (DateTime? value) {
                  setState(() {
                    selectedDate = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fermer le pop-up sans enregistrer
          },
          child: Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text("Envoyer"),
        ),
      ],
    );
  }
}

// Fonction pour ouvrir le pop-up
void showAddWeightPopup(BuildContext context, String userId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddWeightPopup(userId: userId);
    },
  );
}
