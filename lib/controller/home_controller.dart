import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:iread/model/book_model.dart';

class HomeController extends GetxController{


  RxList<BookModel> books = <BookModel>[].obs;


  fetchBooks() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('books').get();
    books.clear();
    for (var book in snapshot.docs) {
      books.add(BookModel.fromJson(book));
    }}


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBooks();
  }
}