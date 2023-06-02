import '../clients/sharedPrefs.dart';

class ChoosePlantViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();

  void setIsReturningUser(bool value) {
    sharedPrefs.setIsReturningUser(value);
  }
}
