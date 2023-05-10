import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:vector_math/vector_math_64.dart';
import '../model/plantType.dart';

import '../clients/sharedPrefs.dart';

class PlantPageARView extends StatefulWidget {
  const PlantPageARView({Key? key}) : super(key: key);

  @override
  _PlantPageARViewState createState() => _PlantPageARViewState();
}

class _PlantPageARViewState extends State<PlantPageARView> {
  bool didAddPlant = false;
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ARView(
        onARViewCreated: onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
      Container(
          margin: const EdgeInsets.only(top: 65.0),
          child: Row(children: [
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  width: 32.0,
                  height: 32.0,
                  child: Image.asset('assets/images/icons/Cross.png',
                      width: 24.0, height: 24.0)),
            ),
          ]))
    ]));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showPlanes: true,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    if (!didAddPlant) {
      ARHitTestResult singleHitTestResult = hitTestResults.firstWhere(
          (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
      ARPlaneAnchor newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        anchors.add(newAnchor);
        String modelURL = _getModelUrl();
        ARNode newNode = ARNode(
            type: NodeType.webGLB,
            uri: modelURL,
            scale: Vector3(0.2, 0.2, 0.2),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor =
            await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          nodes.add(newNode);
          didAddPlant = true;
          arSessionManager?.onInitialize(
            showPlanes: false,
            handlePans: true,
            handleRotation: true,
          );
        }
      }
    }
  }

  String _getModelUrl() {
    int plantIndex = SharedPrefs().getPlantType() ?? 0;
    int plantProgress = SharedPrefs().getPlantProgress();
    return '${PlantType.values[plantIndex].getModelFolderURL()}/$plantProgress.glb';
  }
}
