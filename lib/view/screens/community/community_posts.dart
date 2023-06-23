import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iread/controller/auth_controller.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/model/user_model.dart';
import 'package:iread/view/widgets/post_card.dart';
import 'package:photo_view/photo_view.dart';

import '../../../model/post_model.dart';
import '../../widgets/custom_text_form_field.dart';
import 'community.dart';
import 'package:intl/intl.dart';

class CommunityPosts extends StatelessWidget {
  const CommunityPosts({Key? key, required this.sectionName, required this.sectionId, required this.user}) : super(key: key);

  final String sectionId;
  final String sectionName;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final CommunityPostsController controller = Get.put(CommunityPostsController(sectionName: sectionName));

    return Scaffold(
      appBar: AppBar(
        title: Text(sectionName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('communityGroups').doc(sectionId).collection('posts').snapshots(),
            builder: (BuildContext context, snapshot){

              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              var posts = snapshot.data!.docs.toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    RxBool liked = false.obs;
                    RxBool saved = false.obs;
                    PostModel post = PostModel.fromJson(posts[index].data());
                    return IntrinsicHeight(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.indigo,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                          'assets/images/${post.ownerImage}.png'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          '${post.owner}',
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(onPressed: () {},
                                    icon: Icon(Icons.more_horiz))
                              ],
                            ).paddingAll(10),
                            Text(post.text!,style: style2,).paddingAll(20),
                            SizedBox(
                              height: 10,
                            ),
                            if(post.image != '')
                            InkWell(
                              onTap: () {
                                Get.to(() =>
                                    FullScreenImageScreen(
                                        imageUrl: '${post.image}'));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.blue),
                                ),
                                height: Get.height * 0.3,
                                width: Get.width,
                                child: PhotoView(
                                  imageProvider: NetworkImage('${post.image}'),
                                  disableGestures: true,
                                  filterQuality: FilterQuality.high,
                                ),
                              ).paddingAll(10),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(AuthController.instance.firebaseUser.value!.uid)
                                      .collection('savedPosts')
                                      .doc(posts[index].id)
                                      .snapshots(),
                                  builder: (BuildContext context, saveSnapshot) {
                                    if (saveSnapshot.hasData && saveSnapshot.data != null) {
                                      final isSaved = saveSnapshot.data!.exists;

                                      return IconButton(
                                        onPressed: () async {
                                          final postId = posts[index].id;
                                          final reactsCollection = FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(AuthController.instance.firebaseUser.value!.uid)
                                              .collection('savedPosts')
                                              .doc(postId);

                                          if (isSaved) {
                                            reactsCollection.delete();
                                            saved.value = false;
                                          } else {
                                            reactsCollection.set(post.toJson());
                                            saved.value = true;
                                          }
                                        },
                                        icon: isSaved
                                            ? Icon(Icons.unarchive, color: Colors.red)
                                            : Icon(Icons.archive, color: Colors.green),
                                      );
                                    }

                                    return IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.archive, color: Colors.green),
                                    );
                                  },
                                ),

                                SizedBox(width: 1),
                                Text(NumberFormat('#,###').format(post.comments?.length)),
                                IconButton(
                                  onPressed: () {
                                    TextEditingController commentText = TextEditingController();
                                    Get.bottomSheet(
                                      // Your bottom sheet content here
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: post.comments?.length,
                                                itemBuilder: (context,
                                                    index) {
                                                  return Card(
                                                    color: Colors.teal.withOpacity(0.8),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                    child: ListTile(
                                                      title: Text('${post.comments?[index].values.first}'),
                                                      subtitle: Text('${post.comments?[index].keys.first}'),
                                                    ),
                                                  ).paddingAll(5);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextFormField(
                                                      label: 'Comment',
                                                      icon: Icon(Icons.message),
                                                      controller: commentText,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore.instance.collection('communityGroups').
                                                      doc(sectionId).collection('posts').doc(posts[index].id).set({
                                                        'comments': FieldValue.arrayUnion([{user.name:commentText.text}])
                                                      },SetOptions(merge: true));
                                                      Get.back();
                                                      commentText.clear();
                                                    },
                                                    icon: Icon(Icons.send),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.comment),
                                ),
                                SizedBox(width: 1),
                                Text(NumberFormat('#,###').format(post.reacts)),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('communityGroups')
                                      .doc(sectionId)
                                      .collection('posts')
                                      .doc(posts[index].id)
                                      .collection('reacts')
                                      .doc(AuthController.instance.firebaseUser.value!.uid)
                                      .snapshots(),
                                  builder: (BuildContext context, saveSnapshot) {
                                    if (saveSnapshot.hasData && saveSnapshot.data != null) {
                                      final docData = saveSnapshot.data?.data();
                                      final isLiked = docData != null;

                                      return IconButton(
                                        onPressed: () async {
                                          final reactsCollection = FirebaseFirestore.instance
                                              .collection('communityGroups')
                                              .doc(sectionId)
                                              .collection('posts')
                                              .doc(posts[index].id)
                                              .collection('reacts')
                                              .doc(AuthController.instance.firebaseUser.value!.uid);
                                          final reactsNum = FirebaseFirestore.instance
                                              .collection('communityGroups')
                                              .doc(sectionId)
                                              .collection('posts')
                                              .doc(posts[index].id);

                                          if (isLiked) {
                                            reactsNum.update({'reacts': FieldValue.increment(-1)});
                                            reactsCollection.delete();
                                            liked.value = false;
                                          } else {
                                            reactsNum.update({'reacts': FieldValue.increment(1)});
                                            reactsCollection.set({
                                              "uid":
                                              AuthController.instance.firebaseUser.value?.uid ?? ''
                                            });
                                            liked.value = true;
                                          }
                                        },
                                        icon: isLiked
                                            ? Icon(Icons.favorite, color: Colors.red)
                                            : Icon(Icons.favorite_border),
                                      );
                                    }

                                    return IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border));
                                  },
                                ),

                              ],
                            ).paddingSymmetric(horizontal: 10),
                          ],
                        ),
                      ),
                    ).paddingAll(15);
                  },
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: 'New post',
                  icon: Icon(Icons.edit),
                  controller: controller.postController,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      controller.pickImage();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      controller.addPost(sectionId, sectionName, controller.postController.text, controller.image.value, sectionId);
                    },
                  ),
                ],
              ),
            ],
          ).paddingAll(5),
        ],
      ),
    );
  }
}


///

// class CommunityPosts extends GetWidget<CommunityPostsController> {
//   const CommunityPosts({Key? key, required this.sectionName, required this.sectionId, required this.user}) : super(key: key);
//
//   final String sectionId;
//   final String sectionName;
//   final UserModel user;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: Get.height * 0.1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipOval(
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.grey,
//                     child: Image.asset(
//                       'assets/images/${user.gender}.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: TextFormField(
//                     readOnly: true,
//                     // onTap: () => controller.addPost(),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       hintText: "What's on your mind.",
//                     ),
//                   ).paddingSymmetric(horizontal: 10),
//                 ),
//                 Container(
//                   width: 50,
//                   child: IconButton(
//                     onPressed: () async {
//                       controller.pickImage();
//                     },
//                     icon: Icon(Icons.image, size: 30),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20,),
//           StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('communityGroups').doc(sectionId).collection('posts').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     RxBool liked = false.obs;
//                     var post = snapshot.data!.docs[index];
//                     var id = snapshot.data!.docs[index].id;
//                     var comments = FirebaseFirestore.instance.collection('posts')
//                         .doc(id).collection('comments')
//                         .snapshots();
//                     var photo = FirebaseFirestore.instance.collection('posts')
//                         .doc(id).collection('photo')
//                         .snapshots();
//                     var reacts = FirebaseFirestore.instance.collection('posts')
//                         .doc(id).collection('reacts')
//                         .snapshots();
//                     return IntrinsicHeight(
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           side: BorderSide(
//                             color: Colors.indigo,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       height: 50,
//                                       width: 50,
//                                       child: Image.asset(
//                                           'assets/images/${user.gender}.png'),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment
//                                           .start,
//                                       children: [
//                                         Text(
//                                           '${post.data()['owner']}',
//                                           style: GoogleFonts.cairo(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 IconButton(onPressed: () {},
//                                     icon: Icon(Icons.more_horiz))
//                               ],
//                             ).paddingAll(10),
//                             Expanded(
//                               child: TextFormField(
//                                 maxLines: null,
//                                 initialValue: '${post.data()['text']}',
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   enabled: false,
//                                 ),
//                               ).paddingAll(20),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             StreamBuilder(
//                               stream: photo,
//                               builder: (context, photoSnap) {
//                                 if (!photoSnap.hasData) {
//                                   return Container(); // Placeholder for photo
//                                 }
//                                 PhotoModel photo = PhotoModel.fromJson(
//                                     photoSnap.data!.docs.first.data());
//                                 return InkWell(
//                                   onTap: () {
//                                     Get.to(() =>
//                                         FullScreenImageScreen(
//                                             imageUrl: photo.photo));
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 1, color: Colors.blue),
//                                     ),
//                                     height: Get.height * 0.3,
//                                     width: Get.width,
//                                     child: PhotoView(
//                                       imageProvider: NetworkImage(photo.photo),
//                                       disableGestures: true,
//                                     ),
//                                   ).paddingAll(10),
//                                 );
//                               },
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Divider(
//                               height: 1,
//                               thickness: 1,
//                               indent: 10,
//                               endIndent: 10,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(Icons.save),
//                                 ),
//                                 SizedBox(width: 1),
//                                 StreamBuilder(
//                                   stream: comments,
//                                   builder: (context, commentSnap) {
//                                     if (!commentSnap.hasData ||
//                                         commentSnap.data!.docs.isEmpty) {
//                                       return Text('0');
//                                     }
//                                     return Text(NumberFormat('#,###').format(
//                                         commentSnap.data!.docs.length));
//                                   },
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     TextEditingController commentText = TextEditingController();
//                                     Get.bottomSheet(
//                                       // Your bottom sheet content here
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white),
//                                         child: Column(
//                                           children: [
//                                             Expanded(
//                                               child: StreamBuilder(
//                                                 stream: comments,
//                                                 builder: (context, commentSnap) {
//                                                   if (!commentSnap.hasData ||
//                                                       commentSnap.data!.docs
//                                                           .isEmpty) {
//                                                     return Center(
//                                                       child: Text('No comments'),
//                                                     );
//                                                   }
//                                                   List<
//                                                       QueryDocumentSnapshot> commentDocuments = commentSnap
//                                                       .data!.docs;
//                                                   return ListView.builder(
//                                                     itemCount: commentDocuments
//                                                         .length,
//                                                     itemBuilder: (context,
//                                                         index) {
//                                                       CommentModel comment = CommentModel
//                                                           .fromJson(
//                                                           commentDocuments[index]
//                                                               .data() as Map<
//                                                               String,
//                                                               dynamic>);
//                                                       return Card(
//                                                         child: ListTile(
//                                                           title: Text(comment
//                                                               .owner ?? ''),
//                                                           subtitle: Text(
//                                                               comment.text ?? ''),
//                                                         ),
//                                                       );
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.all(10),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     child: CustomTextFormField(
//                                                       label: 'Comment',
//                                                       icon: Icon(Icons.message),
//                                                       controller: commentText,
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 10),
//                                                   IconButton(
//                                                     onPressed: () async {
//                                                       await FirebaseFirestore
//                                                           .instance.collection(
//                                                           'posts')
//                                                           .doc(id)
//                                                           .collection('comments')
//                                                           .add(CommentModel(
//                                                           owner: user.name,
//                                                           senderPhoto: 'assets/images/${user.gender}.png',
//                                                           text: commentText.text)
//                                                           .toJson());
//                                                       commentText.clear();
//                                                     },
//                                                     icon: Icon(Icons.send),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   icon: Icon(Icons.comment),
//                                 ),
//                                 SizedBox(width: 1),
//                                 StreamBuilder(
//                                   stream: reacts,
//                                   builder: (context, likesSnap) {
//                                     if (!likesSnap.hasData || likesSnap.data!.docs
//                                         .isEmpty) {
//                                       return Text('0');
//                                     }
//                                     return Text(NumberFormat('#,###').format(
//                                         likesSnap.data!.docs.length));
//                                   },
//                                 ),
//                                 IconButton(
//                                   onPressed: () async {
//                                     final reactsCollection = FirebaseFirestore
//                                         .instance
//                                         .collection('posts')
//                                         .doc(post.id)
//                                         .collection('reacts')
//                                         .doc(
//                                         AuthController.instance.firebaseUser.value
//                                             ?.uid);
//                                     final docSnapshot = await reactsCollection
//                                         .get();
//                                     final isLiked = docSnapshot.exists;
//
//                                     if (isLiked) {
//                                       reactsCollection.delete();
//                                       liked.value = false;
//                                     } else {
//                                       reactsCollection.set({
//                                         "uid": AuthController.instance
//                                             .firebaseUser.value?.uid ?? '',
//                                       });
//                                       liked.value = true;
//                                     }
//                                   },
//                                   icon: Obx(() =>
//                                   liked.value
//                                       ? Icon(Icons.favorite, color: Colors.red)
//                                       : Icon(Icons.favorite_border)),
//                                 ),
//                               ],
//                             ).paddingSymmetric(horizontal: 10),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ).paddingAll(10),
//     );
//   }
// }

///

class CommunityPostsController extends GetxController {
  final String sectionName;
  final TextEditingController postController = TextEditingController();

  CommunityPostsController({required this.sectionName});

  RxString image = ''.obs;

  void addPost(
      String sectionId, String sectionName, String postText, String imageUrl, String section) async {
    final reactsCollection = FirebaseFirestore.instance
        .collection('communityGroups')
        .doc(sectionId)
        .collection('posts');

    final newPost = {
      'text': postText,
      'image': imageUrl,
      'owner': AuthController.instance.currentUser.name,
      'ownerImage': AuthController.instance.currentUser.gender, // Replace with the appropriate image file name
      'comments': [],
      'reacts': 0,
    };

    await reactsCollection.add(newPost);
    image.value = '';
    postController.clear();
  }

  pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Upload the image to Firestore storage
      final uploadTask = FirebaseStorage.instance
          .ref('community/$sectionName/${DateTime.now().millisecondsSinceEpoch}.jpg')
          .putFile(File(pickedFile.path));

      await uploadTask.whenComplete(() {});

      // Get the download URL of the uploaded image
      image.value = await uploadTask.snapshot.ref.getDownloadURL();

      update();

      return image.value;
    }

    return image.value; // Return an empty string if no image is picked
  }


  Future<void> savePost(postId) async {
    final userSavedPostsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthController.instance.firebaseUser.value!.uid)
        .collection('savedPosts');

    await userSavedPostsRef.doc(postId).set({'postId': postId});

  }
}



