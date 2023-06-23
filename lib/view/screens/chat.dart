import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iread/controller/auth_controller.dart';
import 'package:iread/model/message_model.dart';
import 'package:iread/view/widgets/message_card.dart';

import '../../core/constance.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('time', descending: true).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<MessageModel> messages = snapshot.data!.docs
              .map((doc) => MessageModel.fromJson(doc))
              .toList();

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  reverse: true, // Reverse the order of the listview
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    MessageModel message = messages[index];
                    return MessageCard(
                      message: message,
                      alignment: AuthController.instance.currentUser.name == message.sender ? Alignment.topRight : Alignment.topLeft,
                      color: AuthController.instance.currentUser.name == message.sender ? Colors.teal : Colors.tealAccent,
                    );
                  }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 0,); },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'Send Message',
                      icon: Icon(Icons.edit),
                      controller: messageController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if(messageController.text.isNotEmpty)
                      FirebaseFirestore.instance.collection('chat').add(
                        MessageModel(
                          sender: AuthController.instance.currentUser.name,
                          content: messageController.text,
                          time: Timestamp.now(),
                        ).toJson(),
                      );
                      messageController.clear();
                    },
                  ),
                ],
              ).paddingAll(5),
            ],
          );
        },
      ),
    );
  }
}

