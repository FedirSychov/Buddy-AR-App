import 'package:BUDdy/clients/sharedPrefs.dart';
import 'package:BUDdy/model/plantType.dart';

class ConfirmPlantViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();

  void removePlantType() {
    sharedPrefs.deletePlantType();
  }

  void setPlantType(PlantType plantType) {
    sharedPrefs.setPlantType(plantType);
  }
}
