enum Activity {
  walking(
      "Take a walk",
      "assets/gifs/people/Walk.gif",
      "Take a short walk to improve your mood and boost your energy levels.",
      "No we aren't going to make you watch a tutorial on how to walk. Walk to your fridge for a beverage or take a stroll outside with Rick in your pocket :D",
      'dQw4w9WgXcQ'),
  stretching(
      'Do stretches',
      "assets/gifs/people/Stretch.gif",
      "Stretching increases muscle blood flow and helps you work efficiently.",
      "Just a few minutes of stretching each day can make a noticeable difference on your overall wellbeing. Let\'s do some simple stretches!",
      'L_xrDAtykMI'),
  meditating(
      'Meditate',
      "assets/gifs/people/Meditation.gif",
      "Meditation gives you a sense of calm, peace and balance instantly.",
      "Meditation helps you focus on the present, reduce all negative emotions and manage stress. It helps  increase self awareness, patience and tolerance.",
      'a2pZOIzbp7Q'),
  yoga(
      'Easy Yoga',
      "assets/gifs/people/Yoga.gif",
      "Yoga helps you relax and helps with anxiety and relieves stress.",
      "Don't worry! It's yoga for beginners. Practicing yoga daily helps improve flexibility, strength and balance. It reduces stress and anxiety.",
      '5yf0nLjAWd8'),
  freeChoice(
      'Free Choice',
      "assets/images/freeChoice.png",
      "Don’t like what you see? Do any activity which you like.",
      "Drink a coffee, have a snack or call your mom. Take a moment to indulge in an activity that refreshes and reenergizes you from within.",
      '8idWv7MLZqw');

  const Activity(this.title, this.assetPath, this.text, this.breakDescription,
      this.videoId);

  final String title;
  final String assetPath;
  final String text;
  final String breakDescription;
  final String videoId;
}
