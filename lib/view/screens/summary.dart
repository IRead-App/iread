import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/controller/home_controller.dart';
import 'package:iread/core/constance.dart';
import 'package:iread/model/book_model.dart';
import 'package:iread/view/screens/book_details.dart';
import 'package:iread/view/widgets/summary_cat_card.dart';

class Summary extends GetWidget<HomeController> {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxString selectedCategory = 'All'.obs;
    RxString searchText = ''.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
              style: bookHeadLine1,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: Get.height * 0.06,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryCard(
                  title: 'All',
                  onTap: () {
                    selectedCategory.value = 'All';
                  },
                  selected: selectedCategory,
                ),
                CategoryCard(
                  title: 'Self Development',
                  onTap: () {
                    selectedCategory.value = 'Self Development';
                  },
                  selected: selectedCategory,
                ),
                CategoryCard(
                  title: 'Novels',
                  onTap: () {
                    selectedCategory.value = 'Novels';
                  },
                  selected: selectedCategory,
                ),
                CategoryCard(
                  title: 'Business',
                  onTap: () {
                    selectedCategory.value = 'Business';
                  },
                  selected: selectedCategory,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height * 0.1,
            child: AnimatedSearchBar(
              closeIcon: Icon(
                Icons.search,
                color: mainColor,
              ),
              label: 'Search...',
              labelStyle: bookHeadLine1,
              onChanged: (value) {
                searchText.value = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (BuildContext context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data != null) {
                  RxList<BookModel> books = RxList<BookModel>(snapshot.data!.docs
                      .where((element) =>
                      element['name']
                          .toString()
                          .trim()
                          .toLowerCase()
                          .contains(searchText.value.trim().toLowerCase()) || element['kind'].toString().toLowerCase() == selectedCategory.value.trim().toLowerCase())
                      .map((doc) => BookModel.fromJson(doc))
                      .toList());

                  return Column(
                    children: [
                      Expanded(
                        child: Obx(
                              () {
                            final filteredBooks = searchText.value.isNotEmpty
                                ? books.where((book) => book.name.toLowerCase().contains(searchText.value.toLowerCase())).toList()
                                : selectedCategory.value != 'All'
                                ? books.where((book) => book.kind.toString().toLowerCase().contains(selectedCategory.value.toLowerCase())).toList()
                                : books;
                            return filteredBooks.isNotEmpty
                                ? ListView.builder(
                              itemCount: filteredBooks.length,
                              itemBuilder: (context, index) {
                                Rx<BookModel> book = filteredBooks[index].obs;
                                return Obx(
                                      () => Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: mainColor),
                                    ),
                                    elevation: 1.5,
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(BookDetails(book: book.value));
                                      },
                                      title: Text(
                                        book.value.name,
                                        style: style2,
                                      ),
                                      subtitle: Text(
                                        book.value.author,
                                        style: style3,
                                      ),
                                      leading: SizedBox(
                                        child: Image.network(book.value.image),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                                : Center(
                              child: Text(
                                'There are no books for this category or name',
                                style: style3,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );


                }
                return Center(
                  child: Text('No books found'),
                );
              },
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 5),
    );
  }
}

///

// import 'package:animated_search_bar/animated_search_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iread/controller/home_controller.dart';
// import 'package:iread/core/constance.dart';
// import 'package:iread/model/book_model.dart';
// import 'package:iread/view/screens/book_details.dart';
//
// class Summary extends GetWidget<HomeController> {
//   const Summary({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     RxString selectedCategory = 'All'.obs;
//     RxString searchText = ''.obs;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Summary', style: appBar),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text('Categories', style: bookHeadLine1),
//           ),
//           SizedBox(height: 5),
//           SizedBox(
//             height: Get.height * 0.06,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 SizedBox(
//                   width: 140,
//                   height: Get.height * 0.08,
//                   child: GestureDetector(
//                     onTap: () {
//                       selectedCategory.value = 'All';
//                     },
//                     child: Card(
//                       elevation: selectedCategory.value == 'All' ? 2.5 : 1.5,
//                       color: selectedCategory.value == 'All'
//                           ? mainColor.withOpacity(0.6)
//                           : Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(
//                           color: mainColor,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'All',
//                           style: style4,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Generate category cards based on fetched books' kind
//                 ...controller.books.map((book) {
//                   String category = book.kind ?? '';
//                   return SizedBox(
//                     width: 120,
//                     child: GestureDetector(
//                       onTap: () {
//                         selectedCategory.value = category;
//                       },
//                       child: Card(
//                         elevation:
//                             selectedCategory.value == category ? 2.5 : 1.5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           side: BorderSide(color: Colors.grey),
//                         ),
//                         child: Center(
//                           child: Text(
//                             category,
//                             style: style4,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Divider(thickness: 1, height: 1),
//           SizedBox(height: 10),
//           SizedBox(
//             height: Get.height * 0.1,
//             child: AnimatedSearchBar(
//               closeIcon: Icon(Icons.search, color: mainColor),
//               label: 'Search...',
//               labelStyle: bookHeadLine1,
//               onChanged: (value) {
//                 searchText.value = value;
//               },
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('books')
//                   .where('kind', isEqualTo: selectedCategory.value)
//                   .where('name', isGreaterThanOrEqualTo: searchText.value)
//                   .snapshots(),
//               builder: (BuildContext context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasData && snapshot.data != null) {
//                   List<BookModel> books = snapshot.data!.docs
//                       .map((doc) => BookModel.fromJson(doc))
//                       .toList();
//                   return ListView.builder(
//                     itemCount: books.length,
//                     itemBuilder: (context, index) {
//                       BookModel book = books[index];
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           side: BorderSide(color: mainColor),
//                         ),
//                         elevation: 1.5,
//                         child: ListTile(
//                           onTap: () {
//                             Get.to(BookDetails(book: book));
//                           },
//                           title: Text(book.name, style: style2),
//                           subtitle: Text(book.author, style: style3),
//                           leading: SizedBox(
//                             child: Image.network(book.image),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: Text('No books found'),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ).paddingSymmetric(horizontal: 5),
//     );
//   }
// }
