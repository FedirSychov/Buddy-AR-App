import 'package:flutter/material.dart';
import 'package:BUDdy/views/confirmPlantView.dart';
import 'package:BUDdy/views/setupSessionView.dart';
import '../clients/sharedPrefs.dart';
import '../model/plantType.dart';
import 'DesignViews/buttons.dart';

class ChoosePlantView extends StatelessWidget {
  const ChoosePlantView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: ListView(
          children: [Header()],
        ));
  }
}

class Header extends StatelessWidget {
  Header({super.key});

  final String title = SharedPrefs().getPlantType() == null
      ? "Let's choose your plant"
      : "Great choice :D";
  final String description = SharedPrefs().getPlantType() == null
      ? "Taking pauses will help your plant grow. You can view growth of your plant in AR mode."
      : "When your plant is fully grown, a new plant will be unlocked as a reward for you.";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(top: 65.0),
          alignment: Alignment.center,
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center)),
      Container(
          margin: const EdgeInsets.only(top: 25.0),
          alignment: Alignment.center,
          width: 320.0,
          child: Text(description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center)),
      Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: Row(children: const [
            Expanded(child: PlantOption(plantTypeOption: PlantType.appleTree)),
            Expanded(child: PlantOption(plantTypeOption: PlantType.monstera))
          ])),
      Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: Row(children: const [
            Expanded(child: PlantOption(plantTypeOption: PlantType.cactus)),
            Expanded(child: PlantOption(plantTypeOption: PlantType.snakePlant))
          ])),
      const Bottom()
    ]);
  }
}

class PlantOption extends StatelessWidget {
  const PlantOption({super.key, required this.plantTypeOption});

  final PlantType plantTypeOption;

  Widget getImage(BuildContext context) {
    int? plantType = SharedPrefs().getPlantType();
    if (plantType != null) {
      if (plantType == plantTypeOption.index) {
        return Container(
            alignment: Alignment.center,
            child: Image.asset(
              plantTypeOption.imagePath,
              height: 160,
              width: 160,
            ));
      } else {
        return Container(
            alignment: Alignment.center,
            child: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.rtl,
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: <Widget>[
                  Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        plantTypeOption.imagePath,
                        height: 160,
                        width: 160,
                      )),
                  Image.asset(
                    "assets/images/Lock.png",
                    height: 64.0,
                    width: 64.0,
                  ),
                ]));
      }
    }
    return InkWell(
        onTap: () {
          if (plantTypeOption == PlantType.appleTree) {
            // Other plants are still WIP
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ConfirmPlantView(plantType: plantTypeOption)));
          }
        },
        child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              plantTypeOption.imagePath,
              height: 160,
              width: 160,
            )));
  }

  Widget getShelf(BuildContext context) {
    int? plantType = SharedPrefs().getPlantType();
    if (plantType != null && plantType != plantTypeOption.index) {
      return Container(
          width: double.infinity,
          height: 24.0,
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5));
    }
    return Container(
        width: double.infinity,
        height: 24.0,
        color: Theme.of(context).colorScheme.inversePrimary);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [getImage(context), getShelf(context)]);
  }
}

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    int? plantType = SharedPrefs().getPlantType();
    if (plantType == null) {
      return Container(
          margin: const EdgeInsets.only(top: 64.0),
          child: Text("Tap on a plant to proceed",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center));
    }
    return Container(
        margin: const EdgeInsets.only(top: 39.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CancelButton('Go back', () {
              Navigator.pop(context);
            }),
          ),
          SimpleButton('Let\'s proceed', () {
            SharedPrefs().setIsReturningUser(true);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SetupSessionView()));
          })
        ]));
  }
}
