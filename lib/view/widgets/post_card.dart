import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iread/model/post_model.dart';
import 'package:iread/model/user_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import '../../controller/auth_controller.dart';
import '../screens/community/community.dart';
import 'custom_text_form_field.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.post, required this.posts, required this.index, required this.user, required this.sectionId}) : super(key: key);

  final PostModel post;
  final List posts;
  final int index;
  final UserModel user;
  final String sectionId;
  @override
  Widget build(BuildContext context) {
    RxBool liked = false.obs;
    RxBool saved = false.obs;
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
            Expanded(
              child: TextFormField(
                maxLines: null,
                initialValue: '${post.text}',
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                ),
              ).paddingAll(20),
            ),
            SizedBox(
              height: 10,
            ),
            if(post.image != null)
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
                )
                ,
              ],
            ).paddingSymmetric(horizontal: 10),
          ],
        ),
      ),
    ).paddingAll(15);
  }
}
