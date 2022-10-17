import 'package:flutter/material.dart';
import '../widget/popup.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}



class _ContactPageState extends State<ContactPage> {

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Popup example'),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
       OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        //textColor: Theme.of(context).primaryColor,
        child: const Text("close"),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton:  FloatingActionButton(
              onPressed: () { showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            ); },
              child:const Icon(Icons.add, color: Colors.white),
            ),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text("contacts")),
            
            body: const Center(
              child: Text("no contact yet"),
            )));
  }
}

