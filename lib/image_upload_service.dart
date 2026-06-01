// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageUploadService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();

//   Future<String?> pickAndUploadImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       return await uploadImage(image);
//     }
//     return null;
//   }

//   Future<String> uploadImage(XFile image) async {
//     try {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference ref = _storage.ref().child('pet_images/$fileName');
//       UploadTask uploadTask = ref.putFile(File(image.path));
//       TaskSnapshot snapshot = await uploadTask;
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
// }


import 'dart:io';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return await uploadImage(image);
    }
    return null;
  }

  Future<String> uploadImage(XFile image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('pet_images/$fileName');
      
      UploadTask uploadTask;

      if (kIsWeb) {
        // ✅ Web Fix: Upload raw bytes instead of File object
        final bytes = await image.readAsBytes();
        uploadTask = ref.putData(bytes);
      } else {
        // ✅ Mobile: Continue using File object
        uploadTask = ref.putFile(File(image.path));
      }

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }
}