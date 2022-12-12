import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangout/model/sharedpreferences.dart';
import 'package:hangout/view/conversation.dart';
import 'package:sqflite/sqlite_api.dart';
import '../widget/updatecontact.dart';
import '../model/contact.dart';
import '../utils.dart';
import '../database/DBhelper.dart';
import '../model/contact.dart';
import 'package:provider/provider.dart';
import '../widget/updatecontact.dart';
import 'thisContact.dart';
import './NewContact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map>? contactList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewContact()));
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text("contacts")),
          body: FutureBuilder(
              future: Provider.of<ContactProvider>(context, listen: false)
                  .selectContact(),
              builder: (BuildContext context, state) {
                if (state.connectionState != ConnectionState.done) {
                  return const SizedBox.shrink();
                } else {
                  return SingleChildScrollView(
                      child: Consumer<ContactProvider>(
                          child: const Center(
                            child: Text(
                              'No Contact added',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          builder: (context, ContactProvider, child) =>
                              ContactProvider.contact.isEmpty
                                  ? child!
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: ContactProvider.contact.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        int key =
                                            ContactProvider.contact[index].id!;
                                        RegisterUnaryCallbackHandler;
                                        return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ThisContact(
                                                          c: ContactProvider
                                                              .contact[index]),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                              ),
                                              margin: const EdgeInsets.only(
                                                  top: 25, left: 10, right: 10),
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 15,
                                                  right: 1,
                                                  bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          AssetImage(
                                                              ContactProvider
                                                                  .contact[
                                                                      index]
                                                                  .picture),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Wrap(
                                                      direction: Axis.vertical,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 200,
                                                              child: Text(
                                                                '${ContactProvider.contact[index].firstName} ${ContactProvider.contact[index].lastName}',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                softWrap: false,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                () => {
                                                                      Navigator.of(context)
                                                                          .push(
                                                                        MaterialPageRoute(
                                                                          builder: (context) => Conversation(c: ContactProvider.contact[index]),
                                                                        ),
                                                                      )
                                                                    },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .message))
                                                          ],
                                                        ),
                                                        Text(
                                                          ContactProvider
                                                              .contact[index]
                                                              .phone,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                                ],
                                              ),
                                            ));
                                      })));
                }
              }));
    });
  }
}
