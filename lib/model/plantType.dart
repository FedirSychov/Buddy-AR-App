enum PlantType {
  BLI("//", "gltf"), BlA("//", "gltf"), BLUB("//", "gltf"), BLAE("//", "gltf");

  const PlantType(this.imagePath, this.gltfPath);
  final String imagePath;
  final String gltfPath;
}