import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSharedPref {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  static Future<void> putValue(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> getValues(
      {required String key, required String value}) async {
    return await storage.read(
      key: key,
    );
  }
}
