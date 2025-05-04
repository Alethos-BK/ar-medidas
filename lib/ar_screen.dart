import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gal/gal.dart';
import 'dart:developer';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  final ScreenshotController screenshotController = ScreenshotController();

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  String selectedUnit = 'cm';
  vector_math.Vector3? lastPosition;
  String? lastDistance;
  late double currentDistance;
  double totalDistance = 0.0;

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AR Medidas')),
      body: Screenshot(
        controller: screenshotController,
        child: Stack(
          children: [
            ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
            Align(
              alignment: const FractionalOffset(0.5, 0.985),
              child: ElevatedButton(
                onPressed: onRemoveEverything,
                child: const Text("Remover Tudo"),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0.90, 0.98),
              child: FloatingActionButton(
                onPressed: takeScreenshot,
                tooltip: 'Capturar Tela',
                child: const Icon(Icons.center_focus_strong_outlined, size: 36),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0.10, 0.98),
              child: FloatingActionButton(
                onPressed: onUndo, //TODO
                tooltip: 'Desfazer',
                child: const Icon(Icons.undo_rounded, size: 36),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 112.0),
                child: DropdownMenu<String>(
                  initialSelection: selectedUnit,
                  trailingIcon: const Icon(Icons.arrow_drop_down, size: 21),
                  inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white.withAlpha((0.8 * 255).toInt()),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    constraints: BoxConstraints.tight(
                      const Size.fromHeight(42),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectedUnit = value!;
                    });
                    if (lastDistance != null) {
                      setState(() {
                        lastDistance =
                            "Distância Atual: ${_formatDistance(currentDistance, selectedUnit)}\nDistância Total: ${_formatDistance(totalDistance, selectedUnit)}";
                      });
                    }
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'mm', label: 'Milímetros'),
                    DropdownMenuEntry(value: 'cm', label: 'Centímetros'),
                    DropdownMenuEntry(value: 'm', label: 'Metros'),
                    DropdownMenuEntry(value: 'in', label: 'Polegadas'),
                    DropdownMenuEntry(value: 'ft', label: 'Pés'),
                    DropdownMenuEntry(value: 'yd', label: 'Jardas'),
                  ],
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white.withAlpha((0.6 * 255).toInt()),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide.none,
                      ),
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (lastDistance != null)
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha((0.6 * 255).toInt()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "$lastDistance",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: true,
      showPlanes: false,
      showWorldOrigin: false,
    );
    this.arObjectManager!.onInitialize();
    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onRemoveEverything() async {
    for (var anchor in anchors) {
      arAnchorManager!.removeAnchor(anchor);
    }
    for (var node in nodes) {
      arObjectManager!.removeNode(node);
    }
    anchors.clear();
    nodes.clear();
    lastPosition = null;
    totalDistance = 0.0;
    setState(() {
      lastDistance = null;
    });
  }

  Future<void> onPlaneOrPointTapped(
    List<ARHitTestResult> hitTestResults,
  ) async {
    var singleHitTestResult = hitTestResults.firstWhere(
      (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
    );

    var position = vector_math.Vector3(
      singleHitTestResult.worldTransform.getColumn(3).x,
      singleHitTestResult.worldTransform.getColumn(3).y,
      singleHitTestResult.worldTransform.getColumn(3).z,
    );

    var newAnchor = ARPlaneAnchor(
      transformation: singleHitTestResult.worldTransform,
    );

    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);

    if (didAddAnchor!) {
      anchors.add(newAnchor);

      var newNode = ARNode(
        type: NodeType.localGLTF2,
        uri: "assets/red_sphere.glb",
        scale: vector_math.Vector3.all(0.03),
        position: vector_math.Vector3.zero(),
      );

      bool? didAddNodeToAnchor = await arObjectManager!.addNode(
        newNode,
        planeAnchor: newAnchor,
      );

      if (didAddNodeToAnchor!) {
        nodes.add(newNode);
      }

      if (lastPosition != null) {
        int numberOfNodes = 20;

        for (int i = 1; i <= numberOfNodes; i++) {
          var interpolatedPosition =
              lastPosition! +
              (position - lastPosition!) * (i / (numberOfNodes + 1));

          var transform =
              vector_math.Matrix4.identity()
                ..setTranslation(interpolatedPosition);

          var lineAnchor = ARPlaneAnchor(transformation: transform);

          bool? anchorAdded = await arAnchorManager!.addAnchor(lineAnchor);

          if (anchorAdded!) {
            anchors.add(lineAnchor);

            var lineNode = ARNode(
              type: NodeType.localGLTF2,
              uri: "assets/white_sphere.glb",
              scale: vector_math.Vector3.all(0.015),
              position: vector_math.Vector3.zero(),
            );

            bool? nodeAddedToAnchor = await arObjectManager!.addNode(
              lineNode,
              planeAnchor: lineAnchor,
            );

            if (nodeAddedToAnchor!) {
              nodes.add(lineNode);
            }
          }
        }

        currentDistance = _calculateDistanceBetweenPoints(
          position,
          lastPosition!,
        );
        totalDistance += currentDistance;

        setState(() {
          lastDistance =
              "Distância Atual: ${_formatDistance(currentDistance, selectedUnit)}\nDistância Total: ${_formatDistance(totalDistance, selectedUnit)}";
        });
      }
      lastPosition = position;
    }
  }

  Future<void> onUndo() async {} //TODO

  double _calculateDistanceBetweenPoints(
    vector_math.Vector3 A,
    vector_math.Vector3 B,
  ) {
    return A.distanceTo(B);
  }

  String _formatDistance(double distance, String unit) {
    switch (unit) {
      case 'mm':
        return "${(distance * 1000).toStringAsFixed(2)} mm";
      case 'cm':
        return "${(distance * 100).toStringAsFixed(2)} cm";
      case 'in':
        return "${(distance * 39.3701).toStringAsFixed(2)} in";
      case 'ft':
        return "${(distance * 3.28084).toStringAsFixed(2)} ft";
      case 'yd':
        return "${(distance * 1.09361).toStringAsFixed(2)} yd";
      case 'm':
      default:
        return "${distance.toStringAsFixed(2)} m";
    }
  }

  Future<void> takeScreenshot() async {
    final image = await screenshotController.capture();

    String getErrorMessage(GalExceptionType type) {
      switch (type) {
        case GalExceptionType.accessDenied:
          return 'Você não tem permissão para acessar a Galeria.';
        case GalExceptionType.notEnoughSpace:
          return 'Sem espaço suficiente para salvar a imagem.';
        case GalExceptionType.notSupportedFormat:
          return 'Formato de arquivo não suportado.';
        case GalExceptionType.unexpected:
          return 'Ocorreu um erro inesperado.';
      }
    }

    if (image == null) return;

    try {
      await Gal.putImageBytes(image, album: 'Screenshots');
    } on GalException catch (e) {
      log(getErrorMessage(e.type));
    }
  }
}
