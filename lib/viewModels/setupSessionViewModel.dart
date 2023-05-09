import '../clients/sharedPrefs.dart';

class SetupSessionViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();
  final basicStudyDuration = "1 hour";
  final basicBreakDuration = "10 mins";

  SetupSessionViewModel() {
    sharedPrefs = SharedPrefs();
    if (sharedPrefs.getSelectedSessionDuration() == null) {
      sharedPrefs.setSelectedSessionDuration(basicStudyDuration);
    }
    if (sharedPrefs.getSelectedBreakDuration() == null) {
      sharedPrefs.setSelectedBreakDuration(basicBreakDuration);
    }
  }

  List<int> translateSessionTimeIntoIntArray() {
    final sessionTime = sharedPrefs.getSelectedSessionDuration();
    List<int> outputArray;
    switch (sessionTime) {
      case "30 mins":
        {
          outputArray = [0, 30, 0];
          break;
        }
      case "1 hour":
        {
          outputArray = [1, 0, 0];
          break;
        }
      case "1,5 hours":
        {
          outputArray = [1, 30, 0];
          break;
        }
      case "2 hours":
        {
          outputArray = [2, 0, 0];
          break;
        }
      default:
        {
          outputArray = [1, 0, 0];
          break;
        }
    }
    return outputArray;
  }

  List<int> translatebrakTimeIntoIntArray() {
    final breakTime = sharedPrefs.getSelectedBreakDuration();
    List<int> outputArray;
    switch (breakTime) {
      case "15 mins":
        {
          outputArray = [0, 15, 0];
          break;
        }
      case "30 mins":
        {
          outputArray = [0, 30, 0];
          break;
        }
      case "45 mins":
        {
          outputArray = [0, 45, 0];
          break;
        }
      case "1 hour":
        {
          outputArray = [1, 0, 0];
          break;
        }
      default:
        {
          outputArray = [0, 15, 0];
          break;
        }
    }
    return outputArray;
  }

  void saveCurrentStudyTime(String selectedDuration) {
    sharedPrefs.setSelectedSessionDuration(selectedDuration);
  }

  void saveCurrentBreakTime(String selectedDuration) {
    sharedPrefs.setSelectedBreakDuration(selectedDuration);
  }

  String getCurrentStudyTime() {
    return sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
  }

  String getCurrentBreakTime() {
    return sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
  }
}
