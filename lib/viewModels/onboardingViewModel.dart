import '../clients/sharedPrefs.dart';

class OnboardingViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();

  void removePlantType() {
    sharedPrefs.deletePlantType();
  }
}
