import 'package:flutter/material.dart';

import '../components/bar_graph.dart';

class HomePage extends StatefulWidget {
  final List weights;

  const HomePage({
    super.key,
    required this.weights,
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
                        child: Text(" Poids: 80 Kg"),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Text("Date: 25/11/2021"),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
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
