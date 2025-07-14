import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class FaceCropper {
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableClassification: false,
    ),
  );

  /// Fungsi utama untuk mendeteksi dan crop wajah dari file
  Future<File?> cropFaceFromFile(File imageFile) async {
    // 1. Decode image (as image library object)
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) return null;

    // 2. Convert to InputImage for ML Kit
    final inputImage = InputImage.fromFile(imageFile);

    // 3. Deteksi wajah
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (faces.isEmpty) return null;

    // Ambil wajah pertama saja
    final Face face = faces.first;
    final rect = face.boundingBox;

    // 4. Crop area wajah
    final int x = rect.left.toInt().clamp(0, originalImage.width - 1);
    final int y = rect.top.toInt().clamp(0, originalImage.height - 1);
    final int w = rect.width.toInt().clamp(0, originalImage.width - x);
    final int h = rect.height.toInt().clamp(0, originalImage.height - y);

    final cropped = img.copyCrop(originalImage, x: x, y: y, width: w, height: h);

    Random random = new Random();
    int randomNumber = random.nextInt(10000000);

    // 5. Simpan ke file sementara
    final dir = await getTemporaryDirectory();
    final croppedFile = File('${dir.path}/${randomNumber}.jpg')
      ..writeAsBytesSync(img.encodeJpg(cropped));

    return croppedFile;
  }

  void dispose() {
    faceDetector.close();
  }
}
