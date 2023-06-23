import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/view/screens/community/community_posts.dart';
import 'package:photo_view/photo_view.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/community_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;



class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community',style: appBar,),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('communityGroups').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final sections = snapshot.data?.docs.toList();
            return Column(
              children: [
                Align(alignment: Alignment.topLeft,child: Text('Categories',style: style2,),),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10,),
                    itemCount: sections!.length,
                    itemBuilder: (context, index) {
                      final section = sections[index].data() as Map<String, dynamic>;
                      final sectionName = section['name'].toString();
                      final sectionId = sections[index].id;
                      return InkWell(
                        onTap: (){
                          Get.to(()=> CommunityPosts(sectionName: sectionName, sectionId: sectionId,user: AuthController.instance.currentUser,));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                height: Get.height * 0.15,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 2,
                                    strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                  color: sectionName == 'Comedy' ? Colors.black : null,
                                  image: DecorationImage(
                                    image: NetworkImage(section['poster'].toString(),),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('${section['name']}',style: sectionStyle,)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}



class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(imageProvider: NetworkImage(imageUrl)),
      ),
    );
  }
}



