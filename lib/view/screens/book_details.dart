import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iread/core/constance.dart';

import '../../model/book_model.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key, required this.book}) : super(key: key);

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name, style: appBar,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            SizedBox(
              height: Get.height * 0.2,
              child: Image.network(book.image),
            ),
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: book.name + '\n',style: bookHeadLine1),
                  TextSpan(text: '  By ${book.author}',style: bookHeadLine2),
                ]
              )),
            ),
            SizedBox(height: 50,),
            Align(alignment: Alignment.centerLeft,child: Text('Summary',style: bookHeadLine1,)),
            SizedBox(height: 20,),
            Align(alignment: Alignment.centerLeft,child: Text(book.summary,style: bookBody1,)),
            SizedBox(height: 50,),
            Align(alignment: Alignment.centerLeft,child: Text('Book Main points',style: bookHeadLine1,)),
            SizedBox(height: 20,),
            Column(
              children: List.generate(book.mainPoints.length, (index) => Text.rich(TextSpan(
                children: [
                  TextSpan(text: '.',style: GoogleFonts.arefRuqaaInk(fontWeight: FontWeight.bold,fontSize: 40)),
                  TextSpan(text: ' ${book.mainPoints[index]}\n',style: bookBody1,),
                ]
              ))),
            ),
            SizedBox(height: 50,),
            Align(alignment: Alignment.centerLeft,child: Text('Book Conclusion',style: bookHeadLine1,)),
            SizedBox(height: 20,),
            Align(alignment: Alignment.centerLeft,child: Text(book.conclusion,style: bookBody1,)),
            SizedBox(height: 50,),
          ],
        ).paddingSymmetric(horizontal: 5),
      ),
    );
  }
}
