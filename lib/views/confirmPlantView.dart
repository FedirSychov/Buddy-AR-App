import 'package:flutter/material.dart';
import 'package:my_app/views/DesignViews/buttons.dart';

import '../clients/sharedPrefs.dart';
import '../model/plantType.dart';
import 'choosePlantView.dart';

class ConfirmPlantView extends StatelessWidget {
  const ConfirmPlantView({super.key, required this.plantType});

  final PlantType plantType;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.only(top: 32.0),
              alignment: Alignment.center,
              child: Text(plantType.name,
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center)),
          Container(
              margin: const EdgeInsets.only(top: 119.0),
              alignment: Alignment.center,
              child: Image.asset(plantType.gifPath, width: 260, height: 260)),
          Container(
              margin: const EdgeInsets.only(top: 18.0),
              alignment: Alignment.center,
              child: Image.asset("assets/images/plantShadow.png",
                  width: 140, height: 20)),
          Container(
              margin: const EdgeInsets.only(top: 117.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CancelButton("Cancel", () {
                    SharedPrefs().deletePlantType();
                    Navigator.pop(context);
                  }),
                ),
                SimpleButton('Adopt', () {
                  SharedPrefs().setPlantType(plantType);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ChoosePlantView()));
                })
              ]))
        ]));
  }
}
