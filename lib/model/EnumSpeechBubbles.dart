enum BubbleType {
  topSessionStart("Let’s start your study session!", false, false),
  topPlantGrew("I grew. Have you checked?", false, false),
  topNewSession("Let’s start a new study session", false, false),
  bottomBuddyProgress(
      "Tap on buddy icon to check your buddy’s progress", true, false),
  bottomSessionIcon(
      "Tap on session icon to set up a new study session", true, true);

  final String message;
  final bool smallText;
  final bool leftSide;

  const BubbleType(this.message, this.smallText, this.leftSide);
}
