import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constance.dart';

class GenderButton extends StatelessWidget {
  const GenderButton({Key? key, required this.selectedGender}) : super(key: key);

  final RxString selectedGender ;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            selectedGender.value == 'female' ? selectedGender.value = 'male' : null;
          },
          child: Container(
            height: selectedGender.value == 'male' ? 100 : 80,
            width: selectedGender.value == 'male' ? 120 : 100,
            decoration: BoxDecoration(
                color: selectedGender.value == 'male' ? mainColor : null,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: selectedGender.value == 'male' ? Colors.green : mainColor, width: selectedGender.value == 'male' ? 2 : 1)
            ),
            child: Image.asset('assets/images/male.png',fit: BoxFit.cover,),
          ),
        ),
        SizedBox(width: Get.width * 0.03,),
        InkWell(
          onTap: (){
            selectedGender.value == 'male' ? selectedGender.value = 'female' : null;
          },
          child: Container(
            height: selectedGender.value == 'female' ? 100 : 80,
            width: selectedGender.value == 'female' ? 120 : 100,
            decoration: BoxDecoration(
                color: selectedGender.value == 'female' ? mainColor : null,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: selectedGender.value == 'female' ? Colors.green : mainColor, width: selectedGender.value == 'female' ? 2 : 1)
            ),
            child: Image.asset('assets/images/female.png',fit: BoxFit.cover,),
          ),
        ),
      ],
    ));
  }
}