import 'dart:io';

import 'package:tflite/tflite.dart';

class TensorFlowLite {
  static loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  static Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 36,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 125.5,
    );

    return output;
  }
}
