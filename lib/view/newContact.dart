import 'package:flutter/material.dart';
import 'package:hangout/model/contact.dart';
import 'package:hangout/model/sharedpreferences.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model/contact.dart';
import '../utils.dart';
import '../database/DBhelper.dart';
import 'package:provider/provider.dart';
import '../style/styles.dart' as S;
import '../model/sharedpreferences.dart';

class NewContact extends StatefulWidget {
  NewContact({super.key});
  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName_controller = TextEditingController();
  TextEditingController lastName_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController update_button = TextEditingController();
  bool enable = false;
  Color textColor = Colors.black;

  @override
  void initState() {
    firstName_controller.text = '';
    lastName_controller.text = '';
    phone_controller.text = '';
    update_button = TextEditingController(text: "add");
    if (Provider.of<ThemeProvider>(context, listen: false).themeMode ==
        ThemeMode.dark) {
      textColor = Colors.white;
    } else {
      textColor = Colors.black;
    }
  }

  void addContact() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        print(Provider.of<ThemeProvider>(context, listen: false).themeMode);
        if (Provider.of<ThemeProvider>(context, listen: false).themeMode ==
            ThemeMode.dark) {
          textColor = Colors.white;
        } else {
          textColor = Colors.black;
        }
        add();
        Navigator.of(context).pop();
      }
    });
  }

  void add() async {
    final NewContact = ContactModel(
        firstName: firstName_controller.text,
        lastName: lastName_controller.text,
        phone: phone_controller.text);
    await Provider.of<ContactProvider>(context, listen: false)
        .insert(NewContact);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, ContactProvider, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                          width: 90,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor)),
                              onPressed: addContact,
                              child: TextField(
                                textAlign: TextAlign.center,
                                enabled: false,
                                controller: update_button,
                              )))
                    ]),
                    Form(
                        key: _formKey,
                        child: SizedBox(
                          width: 370,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("name :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    decoration: TextDecoration.underline,
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28),
                                decoration: S.Style.activeTextField,
                                controller: firstName_controller,
                                validator: ((value) => validator(value)),
                              ),
                              const SizedBox(height: 20),
                              const Text("last name :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    decoration: TextDecoration.underline,
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28),
                                decoration: S.Style.activeTextField,
                                controller: lastName_controller,
                                validator: ((value) => validator(value)),
                              ),
                              const SizedBox(height: 20),
                              const Text("phone :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    decoration: TextDecoration.underline,
                                  )),
                              const SizedBox(height: 20),
                              TextFormField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28),
                                decoration: S.Style.activeTextField,
                                controller: phone_controller,
                                validator: ((value) => validator(value)),
                              ),
                            ],
                          ),
                        ))
                  ])));
    });
  }
}
