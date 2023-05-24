import '../clients/sharedPrefs.dart';

class SetupSessionViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();
  final basicStudyDuration = "1 hour";
  final basicBreakDuration = "15 mins";

  var sessionTimeArray = [
    "20 secs",
    "30 mins",
    "1 hour",
    "1,5 hours",
    "2 hours"
  ];

  var breakTimeArray = ["20 secs", "15 mins", "30 mins", "45 mins", "1 hour"];

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
    String studyDuration =
        sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
    List<int> studyTime = translateSessionTimeIntoIntArray(studyDuration);
    int studyTimeInSeconds = studyTime[0] * 3600 + studyTime[1] * 60 + studyTime[2];
    sharedPrefs.setSessionDuration(studyTimeInSeconds);

    String breakDuration =
        sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
    List<int> breakTime = translateBreakTimeIntoIntArray(breakDuration);
    int breakTimeInSeconds = breakTime[0] * 3600 + breakTime[1] * 60 + breakTime[2];
    sharedPrefs.setBreakDuration(breakTimeInSeconds);
  }

  String getCurrentStudyTime() {
    return sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
  }

  String getCurrentBreakTime() {
    return sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
  }
}
