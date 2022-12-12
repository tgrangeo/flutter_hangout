import 'package:flutter/material.dart';
import 'package:hangout/model/contact.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model/contact.dart';
import '../utils.dart';
import '../database/DBhelper.dart';
import 'package:provider/provider.dart';

class UpdateContact extends StatefulWidget {
  ContactModel c;
  UpdateContact({super.key, required this.c});
  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName_controller = TextEditingController();
  TextEditingController lastName_controller =  TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  @override
  void initState() {
    firstName_controller.text = widget.c.firstName;
    lastName_controller.text = widget.c.lastName;
    phone_controller.text = widget.c.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            //initialValue: widget.c.firstName,
            controller: firstName_controller,
            validator: ((value) => validator_init(value,widget.c.firstName)),
          ),
          TextFormField(
            //initialValue: widget.c.lastName,
            controller: lastName_controller,
            validator: ((value) => validator_init(value, widget.c.lastName)),
          ),
          TextFormField(
            //initialValue: widget.c.phone,
            controller: phone_controller,
            validator: ((value) => validator_init(value,widget.c.phone)),
          ),
          OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final UpdateContact = ContactModel(
                    firstName: firstName_controller.text,
                    lastName: lastName_controller.text,
                    phone: phone_controller.text);
                 await Provider.of<ContactProvider>(context, listen: false)
                  .updateContactNameById(widget.c.id, UpdateContact);
                Navigator.of(context).pop();
              }
            },
            child: const Text("update"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            //textColor: Theme.of(context).primaryColor,
            child: const Text("close"),
          ),
        ],
      ),
    );
  }
}
