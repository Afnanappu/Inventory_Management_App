import 'package:image_picker/image_picker.dart';

Future pickImageFromFile() async {
  // ignore: invalid_use_of_visible_for_testing_member
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (image != null) {
    return image.path;
  } else {
    throw 'Error while picking an image: $image';
  }
}
