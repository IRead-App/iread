import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CommunityPostsController extends GetxController {
  final String sectionName;
  final TextEditingController postController = TextEditingController();
  String? imageUrl;

  CommunityPostsController({required this.sectionName});

  Future<void> sendPost(String sectionName) async {
    final postContent = postController.text;
    if (postContent.isEmpty) {
      return;
    }

    final post = {
      'content': postContent,
      'imageUrl': imageUrl,
      // Other post data
    };

    // Save the post to Firestore
    await FirebaseFirestore.instance
        .collection('community')
        .doc(sectionName)
        .collection('Posts')
        .add(post);

    // Clear the post text field and imageUrl
    postController.clear();
    imageUrl = null;
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the image to Firestore storage
      final uploadTask = FirebaseStorage.instance
          .ref('community/$sectionName/${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putFile(File(pickedFile.path));

      await uploadTask.whenComplete(() {});

      // Get the download URL of the uploaded image
      imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      update();
    }
  }


}
///
// class CommunityPostsController extends GetxController {
//   RxString postImage = ''.obs;
//   RxList<String> likedPosts = <String>[].obs;
//   TextEditingController postContent = TextEditingController();
//
//   addPost(){
//
//     Get.bottomSheet(
//       BottomSheet(
//         onClosing: () {},
//         builder: (context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     SizedBox(height: 10),
//                     IntrinsicHeight(
//                       child: TextFormField(
//                         controller: postContent,
//                         maxLines: 100,
//                         minLines: 15,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           hintText: "What's on your mind.",
//                         ),
//                       ).paddingSymmetric(horizontal: 10),
//                     ),
//                     SizedBox(height: 10,),
//                     Obx(() => Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 2, color: Colors.blue)),
//                         height: Get.height * 0.3,
//                         width: Get.width * 0.5,
//                         child: PhotoView(
//                           imageProvider: NetworkImage(postImage.value),disableGestures: true,loadingBuilder: (context, i){return Center(child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator()));},)).paddingSymmetric(horizontal: 20))
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.4,
//                     child: ElevatedButton(
//                       onPressed: () async {
//
//                         print("//ss${postImage.value}");
//                       },
//                       child: Text(
//                         'Post',
//                         style: style1,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 50,
//                     child: IconButton(
//                       onPressed: () async {
//                         FilePickerResult? result = await FilePicker.platform.pickFiles(
//                           type: FileType.image,
//                         );
//                         if (result != null && result.files.isNotEmpty) {
//                           File file = File(result.files.single.path!);
//                           String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//                           Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
//                           UploadTask uploadTask = reference.putFile(file);
//
//                           TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
//                           if (snapshot.state == TaskState.success) {
//                             String downloadUrl = await reference.getDownloadURL();
//                             postImage.value = downloadUrl;
//                           }
//                         }
//                       },
//                       icon: Icon(Icons.image, size: 30),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//
//   }
//
//
//   pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//     if (result != null && result.files.isNotEmpty) {
//       File file = File(result.files.single.path!);
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
//       UploadTask uploadTask = reference.putFile(file);
//
//       TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
//       if (snapshot.state == TaskState.success) {
//         String downloadUrl = await reference.getDownloadURL();
//         postImage.value = downloadUrl;
//       }
//     }
//     Get.to(()=> AddPost());
//   }
//
// }