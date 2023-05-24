import 'package:BUDdy/viewModels/plantPageARViewModel.dart';
import 'package:BUDdy/views/homeView.dart';
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
import '../model/EnumSpeechBubbles.dart';

class PlantPageARView extends StatefulWidget {
  final bool promptSessionSetUpOnReturn;

  PlantPageARView({super.key, required this.promptSessionSetUpOnReturn});

  final viewModel = PlantPageARViewModel();

  @override
  _PlantPageARViewState createState() => _PlantPageARViewState();
}

class _PlantPageARViewState extends State<PlantPageARView> {
  @override
  void dispose() {
    super.dispose();
    widget.viewModel.arSessionManager!.dispose();
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
                if (widget.promptSessionSetUpOnReturn) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeView(
                              topSpeechBubble: BubbleType.topNewSession,
                              bottomSpeechBubble:
                                  BubbleType.bottomSessionIcon)));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  width: 32.0,
                  height: 32.0,
                  child: Image.asset('assets/images/icons/Cross.png',
                      width: 24.0,
                      height: 24.0,
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          ]))
    ]));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    widget.viewModel.arSessionManager = arSessionManager;
    widget.viewModel.arObjectManager = arObjectManager;
    widget.viewModel.arAnchorManager = arAnchorManager;

    widget.viewModel.arSessionManager!.onInitialize(
      showPlanes: true,
      handlePans: true,
      handleRotation: true,
    );
    widget.viewModel.arObjectManager!.onInitialize();

    widget.viewModel.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    if (!widget.viewModel.didAddPlant) {
      ARHitTestResult singleHitTestResult = hitTestResults.firstWhere(
          (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
      ARPlaneAnchor newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor =
          await widget.viewModel.arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        widget.viewModel.anchors.add(newAnchor);
        String modelURL = widget.viewModel.getModelUrl();
        ARNode newNode = ARNode(
            type: NodeType.webGLB,
            uri: modelURL,
            scale: Vector3(0.2, 0.2, 0.2),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor = await widget.viewModel.arObjectManager!
            .addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          widget.viewModel.nodes.add(newNode);
          widget.viewModel.didAddPlant = true;
          widget.viewModel.arSessionManager?.onInitialize(
            showPlanes: false,
            handlePans: true,
            handleRotation: true,
          );
        }
      }
    }
  }
}
