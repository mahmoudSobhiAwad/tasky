import 'dart:io';

Future<bool> checkFileSize(String filePath) async {
  bool fileSizePassed = false;
  final file = File(filePath);
  if (await file.exists()) {
    final fileSize = await file.length();
    fileSizePassed = fileSize / (1024 * 1024) < 1;
  }
  return fileSizePassed;
}
