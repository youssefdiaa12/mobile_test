import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CameraClass {
  static Future<File?> cameraPicker() async {
    print('Requesting camera permission...');
    PermissionStatus cameraStatus = await Permission.camera.request();
    print('Camera permission status: $cameraStatus');

    if (cameraStatus.isGranted) {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } else {
      print('Camera permission denied');
      return null;
    }
  }

  static Future<File?> galleryPicker() async {
    print('Requesting storage permission...');
    PermissionStatus status;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }
    print('Storage permission status: $status');

    if (status.isGranted) {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } else {
      print('Storage permission denied');
      return null;
    }
  }
}
