import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/controller/auth_controller.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/model/user_model.dart';
import 'package:iread/view/widgets/post_card.dart';

import '../../model/post_model.dart';

class SavedPosts extends StatelessWidget {
  const SavedPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Posts',style: appBar,),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthController.instance.firebaseUser.value!.uid)
            .collection('savedPosts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List posts = snapshot.data!.docs.toList();
          UserModel user = AuthController.instance.currentUser;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              PostModel post = PostModel.fromJson(posts[index].data());
              return PostCard(
                post: post,
                posts: posts,
                index: index,
                user: user,
                sectionId: post.sectionId!,
              );
            },
          );
        },
      ),
    );
  }
}
