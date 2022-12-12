import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangout/model/contact.dart';
import 'package:provider/provider.dart';
import '../model/contact.dart';
import '../model/sms.dart';

class Conversation extends StatefulWidget {
  ContactModel c;
  Conversation({super.key, required this.c});

  @override
  _Conversation createState() => _Conversation();
}

class _Conversation extends State<Conversation> {
  TextEditingController inputController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  late List<SMS> messages;

  @override
  void initState() {
    inputController.text = "";
    messages = [];
    load();
  }

  scrollToBottom() {
    if (listScrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 220)).then((value) {
        listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
      });
    }
  }

  void load() async {
    List<SMS> ret = [];
    await Provider.of<ContactProvider>(context, listen: false)
        .selectMessagesById(widget.c.id!)
        .then((value) => ret = value);
    setState(() {
      messages = ret;
    });
    scrollToBottom();
  }

  void send() async {
    print(inputController.text);
    if (inputController.text != "") {
      SMS tosend = SMS(
        phone: widget.c.phone,
        message: inputController.text,
        contactId: widget.c.id!,
        me: 'me',
      );
      await Provider.of<ContactProvider>(context, listen: false)
          .sendSms(tosend);
    }
    //inputController.text = "";
    load();
  }

  //void sendSubmit(String msg) async {
  //  print(inputController.text);
  //  if (inputController.text != "") {
  //    SMS tosend = SMS(
  //      phone: widget.c.phone,
  //      message: msg,
  //      contactId: widget.c.id!,
  //      me: 'other',
  //    );
  //    await Provider.of<ContactProvider>(context, listen: false)
  //        .sendSms(tosend);
  //    //inputController.text = "";
  //  }
  //  load();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomSheet: buildInput(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.c.firstName),
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: listScrollController,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    //int key = messages[index].id!;
                    RegisterUnaryCallbackHandler;
                    return InkWell(
                        child: messages[index].me == 'me' ? meMsg(index) : otherMsg(index),
                    );
                  }))
        ]));
  }

  Widget otherMsg(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Container(
          constraints: const BoxConstraints(minWidth: 10, maxWidth: 250),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            border: Border.all(
              width: 1,
              color: Colors.grey.shade700,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          child: Text(messages[index].message)),
    ]);
  }

  Widget meMsg(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      Container(
          constraints: const BoxConstraints(minWidth: 10, maxWidth: 250),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          child: Text(messages[index].message)),
    ]);
  }

  Widget buildInput() {
    return Container(
        height: 50,
        margin: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.grey[700]
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1,
                  //onSubmitted: sendSubmit,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  controller: inputController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    fillColor: Colors.grey[850],
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    hintText: 'Type your message...',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: send,
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ));
  }
}
