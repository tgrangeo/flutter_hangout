import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/sharedpreferences.dart';
import '../model/themeModels.dart';
import '../style/styles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import '../l10n/generated/app_localizations.dart';

class LangageSwitcher extends StatefulWidget {
  const LangageSwitcher({super.key});
  @override
  State<LangageSwitcher> createState() => _LangageSwitcher();
}

class _LangageSwitcher extends State<LangageSwitcher> {
  bool light = true;
  bool check = false;
  bool switchDisable = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        width: 360,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  themeProvider.seSelectedLocale("en");
                },
                child: const Text(
                  "EN",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  themeProvider.seSelectedLocale("fr");
                },
                child: const Text(
                  "FR",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}
