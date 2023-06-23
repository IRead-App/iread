import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constance.dart';
import '../../model/book_model.dart';

class RoadMaps extends StatelessWidget {
  const RoadMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String front =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Ffront%20end.png?alt=media&token=a4b0bb5b-0eb0-4a9c-ab87-3b0a90885236';
    String back =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fback%20end.png?alt=media&token=4ee8911d-49b6-4f88-8ec1-31304547476f';
    String flutter =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fflutter.png?alt=media&token=e813c5be-16bc-4cc7-a03d-8b777b950954';
    String cyber =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fcyber%20security.jpg?alt=media&token=598f26e1-9a83-4683-8440-a2c3bd87e367';
    String machine =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fmachine%20learning.jpg?alt=media&token=3faab927-8f2f-47fd-83f5-02bddd5301fc';
    String entrepreneur =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fentrepreneur.jpg?alt=media&token=7ee9f9ed-ad21-4517-a147-93bd4aa9aa8a';
    String marketing =
        'https://firebasestorage.googleapis.com/v0/b/i-read-da722.appspot.com/o/roadMaps%2Fdigital%20marketing.jpg?alt=media&token=d6cdf836-06a3-4be0-8007-bdf43b45f77d';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Road Maps',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (BuildContext context, snapshot) {

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List books = snapshot.data!.docs.toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Front End', style: style2),
                              subtitle:
                                  Text('Expected Duration 9 Mo', style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(front),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Back End', style: style2),
                              subtitle:
                                  Text('Expected Duration 9 Mo', style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(back),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Flutter', style: style2),
                              subtitle:
                                  Text('Expected Duration 6 Mo', style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(flutter),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Cyber Security', style: style2),
                              subtitle: Text('Expected Duration 18 Mo',
                                  style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child:
                                    Image.network(cyber, fit: BoxFit.contain),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Machine Learning', style: style2),
                              subtitle: Text('Expected Duration 32 Mo',
                                  style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child:
                                    Image.network(machine, fit: BoxFit.contain),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Digital Marketing', style: style2),
                              subtitle: Text('Expected Duration 32 Mo',
                                  style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(marketing,
                                    fit: BoxFit.contain),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: mainColor),
                            ),
                            elevation: 1.5,
                            child: ListTile(
                              onTap: () {
                                // Get.to(BookDetails(book: book));
                              },
                              title: Text('Entrepreneur', style: style2),
                              subtitle: Text('Expected Duration 32 Mo',
                                  style: style4),
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(entrepreneur,
                                    fit: BoxFit.contain),
                              ),
                              trailing: TextButton(
                                onPressed: () {},
                                child: Text('Details...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 5),
    );
  }
}
