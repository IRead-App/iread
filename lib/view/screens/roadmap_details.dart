import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/model/roadmap_model.dart';

class RoadmapDetails extends StatelessWidget {
  const RoadmapDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('roadmaps').snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var roadmaps = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: roadmaps.length,
                  itemBuilder: (BuildContext context, index) {
                    RoadmapModel roadmap = RoadmapModel.fromJson(roadmaps[index].data());
                    return Column(
                      children: [
                        SizedBox(height: 20,),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: roadmap.details.keys.toList().reversed.length,
                          itemBuilder: (BuildContext context, int index2) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(height: Get.height * 0.2,width: Get.width * 0.3,child: Image.network(roadmap.details.values.toList()[index2]['image'])),
                                Text(roadmap.details.values.toList()[index2]['mainPoints'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(', ', '\n\n'),style: style2,),
                              ],
                            );
                          }, separatorBuilder: (BuildContext context, int index) { return Column(
                            children: [
                              SizedBox(height: 10,),
                              Divider(thickness: 2,height: 2,),
                              SizedBox(height: 10,),
                            ],
                          ); },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );



  }
}
