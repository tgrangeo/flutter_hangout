import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/contactpage.dart';
import '../database/DBhelper.dart';
import '../utils.dart';
import '../model/sharedpreferences.dart';
import '../widget/themeWidgets.dart';
//import '../model/Color.dart';
// import '../l10n/generated/app_localizations.dart';
import '../view/settingsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                Theme.of(context).primaryColor,
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
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("message"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
          body: const Center(child: Text('no conv')));
    });
  }
}
