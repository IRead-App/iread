import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../core/constance.dart';
import '../../model/message_model.dart';
import 'package:intl/intl.dart';


class MessageCard extends StatelessWidget {
  const MessageCard({Key? key, required this.message, required this.alignment, this.color}) : super(key: key);

  final MessageModel message;
  final Color? color;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IntrinsicHeight(
        child: Padding(
          padding: AuthController.instance.currentUser.name == message.sender ? EdgeInsets.only(left: 80) : EdgeInsets.only(right: 80),
          child: Card(
            color: color,
            shape: AuthController.instance.currentUser.name == message.sender
                ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            )
                : RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.sender,
                        style: style4,
                      ),
                      Text(
                        message.content,
                        style: style3,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat('MM-dd-yyyy hh:mm a').format(message.time.toDate()),
                      style: style4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
