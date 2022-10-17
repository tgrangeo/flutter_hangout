import 'package:flutter/material.dart';
import 'package:hangout/view/contactpage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ContactPage(),
                  ),
                );
              },
              child: const Icon(Icons.account_circle_rounded),
            ),
            appBar: AppBar(
              title: const Text("message"),
            ),
            body: const Center(
              child: Text("no conv yet"),
            )));
  }
}
