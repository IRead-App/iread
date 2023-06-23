import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/core/constance.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.title, required this.selected, this.onTap}) : super(key: key);

  final String title;
  final RxString selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 120,
        child: Card(
          color: selected.value == title ? Colors.teal : null,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
          child: Center(
              child: Text(title,
                style: style4,
              )),
        ),
      ),
    ));
  }
}
