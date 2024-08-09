import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddWeight extends StatefulWidget {
  const AddWeight({super.key, this.user_id});
    final user_id;


  @override
  State<AddWeight> createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  final _formKey = GlobalKey<FormState>();
  final poidsController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose

    poidsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
          key: _formKey,
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
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: DateTimeFormField(
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
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final poids = double.parse(poidsController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enregistrement...")));
                      FocusScope.of(context).requestFocus(FocusNode());
                      print("Ajout du poids: $poids");
                      CollectionReference poidsRef =
                          FirebaseFirestore.instance.collection('poids');
                      poidsRef.add({
                        'date': selectedDate,
                        'poid': poids,
                        'user_id': widget.user_id
                      });
                    }
                  },
                  child: Text("Envoyer"),
                ),
              ),
            ],
          )),
    );
  }
}
