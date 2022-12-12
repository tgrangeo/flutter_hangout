import 'package:flutter/material.dart';
import 'package:hangout/model/contact.dart';
import 'package:hangout/model/sharedpreferences.dart';
import '../utils.dart';
import 'package:provider/provider.dart';
import '../style/styles.dart' as S;

class ThisContact extends StatefulWidget {
  ContactModel c;
  ThisContact({super.key, required this.c});
  @override
  _ThisContactState createState() => _ThisContactState();
}

class _ThisContactState extends State<ThisContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName_controller = TextEditingController();
  TextEditingController lastName_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController update_button = TextEditingController();
  bool hasChanged = false;
  bool enable = false;
  Color textColor = Colors.white;

  @override
  void initState() {
    firstName_controller.text = widget.c.firstName;
    lastName_controller.text = widget.c.lastName;
    phone_controller.text = widget.c.phone;
    update_button = TextEditingController(text: "update");
    if (Provider.of<ThemeProvider>(context, listen: false).themeMode ==
        ThemeMode.dark) {
      textColor = Colors.white;
    } else {
      textColor = Colors.black;
    }
  }

  void update() {
    setState(() {
      if (update_button.text == "update") {
        update_button = TextEditingController(text: "save");
        enable = true;
        textColor = Colors.black;
      } else {
        if (_formKey.currentState!.validate()) {
          update_button = TextEditingController(text: "update");
          enable = false;
          print(Provider.of<ThemeProvider>(context, listen: false).themeMode);
          if (Provider.of<ThemeProvider>(context, listen: false).themeMode ==
              ThemeMode.dark) {
            textColor = Colors.white;
          } else {
            textColor = Colors.black;
          }
          save();
        }
      }
    });
  }

  void save() async {
    final ThisContact = ContactModel(
        firstName: firstName_controller.text,
        lastName: lastName_controller.text,
        phone: phone_controller.text);
    await Provider.of<ContactProvider>(context, listen: false)
        .updateContactNameById(widget.c.id, ThisContact);
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
          body: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 2.5),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 1, bottom: 10),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundImage: AssetImage(widget.c.picture),
                      ),
                    ),
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
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28),
                                    decoration: update_button.text == "update"
                                        ? S.Style.inactiveTextField
                                        : S.Style.activeTextField,
                                    enabled: enable,
                                    controller: firstName_controller,
                                    validator: ((value) => validator_init(
                                        value, widget.c.firstName)),
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
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28),
                                    decoration: update_button.text == "update"
                                        ? S.Style.inactiveTextField
                                        : S.Style.activeTextField,
                                    enabled: enable,
                                    controller: lastName_controller,
                                    validator: ((value) => validator_init(
                                        value, widget.c.lastName)),
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
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28),
                                    decoration: update_button.text == "update"
                                        ? S.Style.inactiveTextField
                                        : S.Style.activeTextField,
                                    enabled: enable,
                                    controller: phone_controller,
                                    validator: ((value) =>
                                        validator_init(value, widget.c.phone)),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                            width: 90,
                                            height: 40,
                                            child: OutlinedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Theme
                                                                    .of(context)
                                                                .primaryColor)),
                                                onPressed: update,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  enabled: false,
                                                  controller: update_button,
                                                ))),
                                        SizedBox(
                                            width: 90,
                                            height: 40,
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red)),
                                              onPressed: () async {
                                                await ContactProvider
                                                    .deleteProductById(
                                                        widget.c.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("delete",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ))
                                      ]),
                                ],
                              ),
                            ))
                  ])));
    });
  }
}
