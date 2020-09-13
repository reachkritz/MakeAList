import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:makealist/makealist/persistence/Repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

class FilePersistence implements Repository {

  var logger = Logger();

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> getFilename(String type, String key) async {
    return type + '/' + key +'.txt';
  }

  Future<List<String>> getKeys() async {
    final filename = "keys.txt";
    final file = await _localFile(filename);
    // 1
    if (await file.exists()) return await file.readAsLines();
    return null;
  }

  Future<int> getNextIndex() async {
    int index;
    List<String> keys = await getKeys();
    index = getLastKeyFromFile(keys) ?? 0;
    logger.i('The last key found is $index');
    return index;
  }

  int getLastKeyFromFile(List<String> keys) {
    if(keys!=null && keys.isNotEmpty){
      return int.parse(keys.removeLast())+1;
    }
    return 0;
  }

  @override
  Future<Map<String, dynamic>> getObject(String key) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    // 3
    if (await file.exists()) {
      final objectString = await file.readAsString();
      Map<String, dynamic> list = JsonDecoder().convert(objectString);
      logger.i('The list fetched is '+ list.toString());
      return list;
    }
    logger.i('No list found with '+key+' key');
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllObjects() async {
    List<String> keys = await getKeys();
    List<Map<String, dynamic>> listMaps = new List();
    if(keys!=null){
      for (var value in keys) {
        Map<String, dynamic> list = await getObject(value);
        if(list!=null) {
          listMaps.add(list);
        }
      }
    }
    return listMaps;
  }

  @override
  Future<int> saveObject(String key, Map<String, dynamic> object) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    try {
      if (!await file.parent.exists()) await file.parent.create(
          recursive: true);
      final jsonString = JsonEncoder().convert(object);
      logger.i('The list being written to memory ',jsonString);
      await file.writeAsString(jsonString);
    } catch (on, StackTrace) {
        logger.e('Failure while saving the file ', StackTrace);
    }
    int nextIndex = await saveKey(key);
    return nextIndex;
  }

  Future<int> saveKey(String key) async {
    final filename = "keys.txt";
    final file = await _localFile(filename);
    try {
      if (!await file.parent.exists()) await file.parent.create(
          recursive: true);
      logger.i('The key being written to memory ',key);
      await file.writeAsString(key+'\n', mode: FileMode.append);
    } catch (on, Stacktrace){
      logger.e('Failure while saving index ',Stacktrace);
      return int.parse(key);
    }
    List<String> keys = await file.readAsLines();
    return getLastKeyFromFile(keys);
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