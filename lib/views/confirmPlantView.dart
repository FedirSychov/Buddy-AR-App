import 'package:BUDdy/viewModels/confirmPlantViewModel.dart';
import 'package:flutter/material.dart';
import 'package:BUDdy/views/DesignViews/buttons.dart';
import '../model/plantType.dart';
import 'choosePlantView.dart';

class ConfirmPlantView extends StatelessWidget {
  ConfirmPlantView({super.key, required this.plantType});

  final PlantType plantType;
  final ConfirmPlantViewModel viewModel = ConfirmPlantViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: ListView(children: [
              Container(
                  margin: const EdgeInsets.only(top: 65.0),
                  alignment: Alignment.center,
                  child: Text(plantType.name,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center)),
              Container(
                  margin: const EdgeInsets.only(top: 120.0),
                  alignment: Alignment.center,
                  child:
                      Image.asset(plantType.gifPath, width: 260, height: 260)),
              Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/plantShadow.png",
                      width: 140, height: 20)),
              Container(
                  margin: const EdgeInsets.only(top: 120.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15.0),
                          child: CancelButton('Cancel', () {
                            viewModel.removePlantType();
                            Navigator.pop(context);
                          }),
                        ),
                        SimpleButton('Adopt', () {
                          viewModel.setPlantType(plantType);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ChoosePlantView()));
                        })
                      ]))
            ])));
  }
}
