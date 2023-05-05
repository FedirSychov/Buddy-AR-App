enum PlantType {
  APPLETREE("Pocket Apple Tree", "assets/images/appleTree.png",
      "assets/gifs/AppleTree.gif", "AppleTree.glb"),
  MONSTERA("Monstera", "assets/images/monstera.png", "assets/gifs/Monstera.gif",
      "Monstera.glb"),
  CACTUS("Cactus", "assets/images/cactus.png", "assets/gifs/Cactus.gif",
      "Cactus.glb"),
  SNAKEPLANT("Snake Plant", "assets/images/snakePlant.png",
      "assets/gifs/SnakePlant.gif", "SnakePlant.glb");

  // GitHub needs to be public
  final String name;
  final String remoteModelsPath =
      "https://github.com/FedirSychov/Buddy-AR-App/raw/main/assets/models/";
  final String imagePath;
  final String gifPath;
  final String fileName;

  const PlantType(this.name, this.imagePath, this.gifPath, this.fileName);

  String getModelURL() => remoteModelsPath + fileName;
}
