import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class CustomPhoneFormField extends StatelessWidget {
  const CustomPhoneFormField({Key? key, required this.countryCode, required this.countryPhoneCode})
      : super(key: key);

  final RxString countryCode;
  final RxString countryPhoneCode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone',
        border: OutlineInputBorder(),
        prefix: Obx(() => Text.rich(TextSpan(
          children: [
            TextSpan(text: getCountryFlagEmoji(countryCode.value),style: TextStyle(fontSize: 20),),
            TextSpan(text: ' | ',style: TextStyle(fontSize: 20),),
            TextSpan(text: countryPhoneCode.value, style: TextStyle(fontSize: 20),),
          ]
        ))),
        prefixStyle: TextStyle()
      ),
      autofillHints: [AutofillHints.telephoneNumber],
      enabled: true,
      onSaved: (phone) {},
      onChanged: (phone) => print('saved $phone'),
    );
  }

  String getCountryFlagEmoji(String countryCode) {
    final flag = EmojiConverter.fromAlpha2CountryCode(countryCode);
    return flag;
  }

}
