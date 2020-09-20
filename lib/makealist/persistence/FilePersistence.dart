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

  Future<int> getKeyFromFile() async {
    final filename = "keys.txt";
    final file = await _localFile(filename);
    // 1
    if (await file.exists()) {
      String index = await file.readAsString();
      return int.parse(index.trim());
    }
      return null;
  }

  Future<int> getNextIndex() async {
    int index;
    index = getKeyFromFile() ?? 0;
    logger.i('The last key found is $index');
    return index;
  }


  @override
  Future<Map<String, dynamic>> getObject(String key) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
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
    final listDir = new Directory(await _localPath);
    List<Map<String, dynamic>> listMaps;
    listDir.exists().then((isThere) {
      listMaps = isThere ? listAllFiles(listDir) : new List();
    });

    return listMaps;
  }

  List<Map<String, dynamic>> listAllFiles(Directory listDir) {
    List<Map<String, dynamic>> listMaps = new List();
    Stream<FileSystemEntity> list = listDir.list(recursive: false);
    list.forEach((element) async {
      if(element is File){
        final objectString = await element.readAsString();
        Map<String, dynamic> list = JsonDecoder().convert(objectString);
        listMaps.add(list);
      }
    });
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
      await file.writeAsString(jsonString,mode: FileMode.write);
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
      await file.writeAsString(key+'\n', mode: FileMode.write);
    } catch (on, Stacktrace){
      logger.e('Failure while saving index ',Stacktrace);
      return int.parse(key);
    }
    return int.parse(key)+1;
  }

  @override
  Future<bool> updateObject(String key, Map<String, dynamic> object) async {
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    bool result = false;
      try {
        if (await file.parent.exists()) {
          final jsonString = JsonEncoder().convert(object);
          logger.i('The list being written to memory ',jsonString);
          await file.writeAsString(jsonString,mode: FileMode.write);
          result = true;
        } else {
          logger.i('File not found!');
          result = false;
        }
      } catch (on, StackTrace) {
        logger.e('Failure while saving the file ', StackTrace);
        result = false;
      }
    return result;
  }

  @override
  Future<void> removeImage(String key) {
    // TODO: implement removeImage
    throw UnimplementedError();
  }

  @override
  Future<bool> removeObject(String key) async{
    final filename = await getFilename('lists', key);
    final file = await _localFile(filename);
    bool result = false;
    try {
      if (await file.parent.exists()){
        await file.delete();
        result = true;
      } else {
        result = false;
      }
    } catch(on, StackTrace) {
       logger.e('Failure while saving the file ', StackTrace);
       result = false;
    }
    return result;
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