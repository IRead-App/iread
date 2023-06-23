import 'package:flutter/material.dart';


class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.image, this.onTap, this.fit = BoxFit.cover}) : super(key: key);

  final String image;
  final BoxFit? fit ;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: 120,
        child: Image.asset(image,fit: fit,),
      ),
    );
  }
}
