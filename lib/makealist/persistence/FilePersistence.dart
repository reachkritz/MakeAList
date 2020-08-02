import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:makealist/makealist/persistence/Repository.dart';
import 'package:path_provider/path_provider.dart';

class FilePersistence implements Repository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> getFilename(String type, String key) async {
    return type + '/' + key;
  }

  @override
  Future<Uint8List> getImage(String key) async {
    final filename = await getFilename('images', key);
    final file = await _localFile(filename);
    // 1
    if (await file.exists()) return await file.readAsBytes();
    return null;
  }

  @override
  Future<String> getString(String key) async {
    final filename = await getFilename('strings', key);
    final file = await _localFile(filename);
    // 2
    if (await file.exists()) return await file.readAsString();
    return null;
  }

  @override
  Future<Map<String, dynamic>> getObject(String key) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    // 3
    if (await file.exists()) {
      final objectString = await file.readAsString();
      return JsonDecoder().convert(objectString);
    }
    return null;
  }

  @override
  Future<String> saveImage(String key, Uint8List image) async {
    // 1
    final filename = await getFilename('images', key);
    // 2
    final file = await _localFile(filename);
    // 3
    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    // 4
    await file.writeAsBytes(image);
    return filename;
  }

  @override
  void saveObject(String key, Map<String, dynamic> object) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    // 5
    final jsonString = JsonEncoder().convert(object);
    await file.writeAsString(jsonString);
  }

  @override
  void saveString(String key, String value) async {
    final filename = await getFilename('strings', key);
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    // 6
    await file.writeAsString(value);
  }

  @override
  Future<void> removeImage(String key) {
    // TODO: implement removeImage
    throw UnimplementedError();
  }

  @override
  Future<void> removeObject(String key) {
    // TODO: implement removeObject
    throw UnimplementedError();
  }

  @override
  Future<void> removeString(String key) {
    // TODO: implement removeString
    throw UnimplementedError();
  }
}
