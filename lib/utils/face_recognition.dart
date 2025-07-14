import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceRecognizer {
  late Interpreter _interpreter;
  final int inputSize = 112;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/mobilefacenet.tflite');
  }

  Future<List<double>> getEmbeddingFromFile(File imageFile) async {

    await loadModel();

    final image = img.decodeImage(await imageFile.readAsBytes());
    if (image == null) throw Exception("Cannot decode image");

    final resized = img.copyResizeCropSquare(image, size: inputSize);
    final input = imageToFloat32(resized);

    final output = List.filled(192, 0.0).reshape([1, 192]);
    _interpreter.run(input, output);

    return List<double>.from(output[0]);
  }

  /// Convert image to Float32List [1,112,112,3] normalized to [-1, 1]
  List<List<List<List<double>>>> imageToFloat32(img.Image image) {
    final input = List.generate(1, (_) => List.generate(
      inputSize,
          (y) => List.generate(
        inputSize,
            (x) {
          final pixel = image.getPixel(x, y); // ini ColorUint8 object
          final r = ((pixel.r - 128) / 128).toDouble();
          final g = ((pixel.g - 128) / 128).toDouble();
          final b = ((pixel.b - 128) / 128).toDouble();
          return [r, g, b];
        },
      ),
    ));
    return input;
  }

  double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0, normA = 0, normB = 0;
    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    return dot / (sqrt(normA) * sqrt(normB));
  }
}
