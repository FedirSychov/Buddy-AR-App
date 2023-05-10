import '../clients/sharedPrefs.dart';

class SetupSessionViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();
  final basicStudyDuration = "1 hour";
  final basicBreakDuration = "10 mins";

  SetupSessionViewModel() {
    sharedPrefs = SharedPrefs();
    if (sharedPrefs.getSelectedSessionDuration() == null) {
      saveCurrentStudyTime(basicStudyDuration);
    }
    if (sharedPrefs.getSelectedBreakDuration() == null) {
      saveCurrentBreakTime(basicBreakDuration);
    }
  }

  List<int> translateSessionTimeIntoIntArray(String sessionTime) {
    List<int> outputArray;
    switch (sessionTime) {
      case "20 secs": // This case is only for demonstration purpose
        {
          outputArray = [0, 0, 20];
          break;
        }
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

  List<int> translateBreakTimeIntoIntArray(String breakTime) {
    List<int> outputArray;
    switch (breakTime) {
      case "20 secs": // This case is only for demonstration purpose
        {
          outputArray = [0, 0, 20];
          break;
        }
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

  void setCountdownValues() {
    String breakDuration = sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
    List<int> studyTime = translateSessionTimeIntoIntArray(breakDuration);
    sharedPrefs.setSessionHoursDuration(studyTime[0]);
    sharedPrefs.setSessionMinsDuration(studyTime[1]);
    sharedPrefs.setSessionSecsDuration(studyTime[2]);

    String studyDuration = sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
    List<int> breakTime = translateBreakTimeIntoIntArray(studyDuration);
    sharedPrefs.setBreakHoursDuration(breakTime[0]);
    sharedPrefs.setBreakMinsDuration(breakTime[1]);
    sharedPrefs.setBreakSecsDuration(breakTime[2]);
  }

  String getCurrentStudyTime() {
    return sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
  }

  String getCurrentBreakTime() {
    return sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
  }
}
