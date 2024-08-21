import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String> pickImageFromFile() async {
  // ignore: invalid_use_of_visible_for_testing_member
  final path = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (path != null) {
    final image = await _saveToAppDir(path);

    return image.path;
  } else {
    throw 'Error while picking an image: $path';
  }
}

Future<File> _saveToAppDir(XFile imgPath) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String path = appDir.path;

  final fileName = DateTime.now().toIso8601String() + '.png';
  var newImage = File('$path/item images/$fileName');
  if (await newImage.exists()) {
    print('Directory $newImage is already exist');
  } else {
    newImage = await newImage.create(recursive: true);
    print('Folder created at: ${newImage.path}');
  }

  return File(imgPath.path).copy(newImage.path);
}
