enum PlantType {
  BLI("//", "First.glb"),
  BlA("//", "Second.glb"),
  BLUB("//", "Third.glb");

  // GitHub needs to be public
  final String remoteModelsPath = "https://github.com/FedirSychov/Buddy-AR-App/raw/main/assets/models/";
  final String fileName;
  final String imagePath;

  const PlantType(this.imagePath, this.fileName);

  String getModelURL() => remoteModelsPath + fileName;
}