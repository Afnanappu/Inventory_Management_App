import 'package:image_picker/image_picker.dart';

Future pickImageFromFile() async {
  final image = await ImagePicker.platform
      .getImageFromSource(source: ImageSource.gallery);

  if (image != null) {
    return image.path;
  } else {
    throw 'Error while picking an image: $image';
  }
}
