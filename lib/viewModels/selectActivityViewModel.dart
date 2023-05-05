import '../model/selectActivityItems.dart';

class SelectActivityViewModel {
  List<ActivityBanner> activityList = [
    ActivityBanner(1, "Let’s take a pause!", "assets/gifs/Walk.gif",
        "Take a short walk to improve your mood and boost your energy levels."),
    ActivityBanner(2, "Do stretches", "assets/gifs/Stretch.gif",
        "Stretching increases muscle blood flow and helps you work efficiently."),
    ActivityBanner(3, "Meditate", "assets/gifs/Meditation.gif",
        "Meditation gives you a sense of calm, peace and balance instantly."),
    ActivityBanner(4, "Easy yoga", "assets/gifs/Yoga.gif",
        "Yoga helps you relax and helps with anxiety and relieves stress."),
    ActivityBanner(5, "Free choice", "assets/gifs/Meditation.gif",
        "Don’t like what you see? Do any activity which you like.")
  ];
}
