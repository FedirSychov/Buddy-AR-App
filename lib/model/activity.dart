enum Activity {
  walking("Let’s take a pause!", 'assets/gifs/Walk.gif',
      "Take a short walk to improve your mood and boost your energy levels."),
  stretching('Do stretches', 'assets/gifs/Stretch.gif',
      "Stretching increases muscle blood flow and helps you work efficiently."),
  meditating('Meditate', 'assets/gifs/Meditation.gif',
      "Meditation gives you a sense of calm, peace and balance instantly."),
  yoga('Easy Yoga', 'assets/gifs/Yoga.gif',
      "Yoga helps you relax and helps with anxiety and relieves stress."),
  freeChoice('Free Choice', 'assets/images/freeChoice.png',
      "Don’t like what you see? Do any activity which you like.");

  const Activity(this.title, this.assetPath, this.text);

  final String title;
  final String assetPath;
  final String text;
}
