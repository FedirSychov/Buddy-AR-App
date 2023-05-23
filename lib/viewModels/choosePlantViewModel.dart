import '../clients/sharedPrefs.dart';

class ChoosePlantViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();

  void setIsRetunringUser(bool value) {
    sharedPrefs.setIsReturningUser(value);
  }
}
