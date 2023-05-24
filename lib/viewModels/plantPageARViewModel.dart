import 'package:BUDdy/clients/sharedPrefs.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import '../model/plantType.dart';

class PlantPageARViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();

  bool didAddPlant = false;
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  String getModelUrl() {
    int plantIndex = SharedPrefs().getPlantType() ?? 0;
    int plantProgress = SharedPrefs().getPlantProgress();
    return '${PlantType.values[plantIndex].getModelFolderURL()}/$plantProgress.glb';
  }
}
