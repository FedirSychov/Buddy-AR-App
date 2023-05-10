enum PlantType {
  appleTree("Pocket Apple Tree", "assets/images/appleTree.png",
      "assets/gifs/AppleTree.gif", "AppleTree"),
  monstera("Monstera", "assets/images/monstera.png", "assets/gifs/Monstera.gif",
      "Monstera"),
  cactus(
      "Cactus", "assets/images/cactus.png", "assets/gifs/Cactus.gif", "Cactus"),
  snakePlant("Snake Plant", "assets/images/snakePlant.png",
      "assets/gifs/SnakePlant.gif", "SnakePlant");

  // GitHub needs to be public
  final String name;
  final String remoteModelsPath =
      "https://github.com/FedirSychov/Buddy-AR-App/raw/main/assets/models/";
  final String imagePath;
  final String gifPath;
  final String folderName;

  const PlantType(this.name, this.imagePath, this.gifPath, this.folderName);

  String getModelFolderURL() => remoteModelsPath + folderName;
}
