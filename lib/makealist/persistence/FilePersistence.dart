import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:makealist/makealist/persistence/Repository.dart';
import 'package:path_provider/path_provider.dart';

class FilePersistence implements Repository {

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> getFilename(String type, String key) async {
    return type + '/' + key;
  }

  Future<List<String>> getKeys() async {
    final filename = "keys";
    final file = await _localFile(filename);
    // 1
    if (await file.exists()) return await file.readAsLines();
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

  Future<List<Map<String, dynamic>>> getAllObjects() async {
    List<String> keys = await getKeys();
    List<Map<String, dynamic>> listMaps = new List();
    if(keys!=null){
      for (var value in keys) {
        listMaps.add(await getObject(value));
      }
    }
    return listMaps;
  }

  @override
  void saveObject(String key, Map<String, dynamic> object) async {
    await saveKey(key);
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    // 5
    final jsonString = JsonEncoder().convert(object);
    await file.writeAsString(jsonString);
  }

  void saveKey(String key) async {
    final filename = "keys.txt";
    final file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);
    // 6
    await file.writeAsString(key, mode: FileMode.append);
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

  @override
  Future<Uint8List> getImage(String key) {
    // TODO: implement getImage
    throw UnimplementedError();
  }

  @override
  Future<String> getString(String key) {
    // TODO: implement getString
    throw UnimplementedError();
  }

  @override
  Future<String> saveImage(String key, Uint8List image) {
    // TODO: implement saveImage
    throw UnimplementedError();
  }

  @override
  void saveString(String key, String value) {
    // TODO: implement saveString
  }
}