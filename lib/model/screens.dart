enum Screens {
  healthyStudying(
      'assets/gifs/plants/OnboardingWelcomeBuddy.gif',
      'Healthy Study Routine',
      'Hello! I am your Buddy. I will help you create a healthy study routine by reminding you to take mini pauses during your study sessions.'),
  nourish('assets/gifs/plants/RelaxedBuddy.gif', 'Nourishing',
      'Your Buddy is connected to an AR plant that grows as you take pauses during your study sessions. Excited? Let’s set your AR plant!'),
  stressRelieving(
      'assets/gifs/plants/BoardingPlantGrow.gif',
      'Stress Relieving',
      'Choose a relaxing stress relieving activity to perform during the pause which will refresh your mind and help you regain your focus.');

  const Screens(this.asset, this.title, this.description);

  final String asset;
  final String title;
  final String description;
}
