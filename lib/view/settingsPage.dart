import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/contactpage.dart';
import '../database/DBhelper.dart';
import '../utils.dart';
import '../model/sharedpreferences.dart';
import '../widget/langageSwitcher.dart';
import '../widget/themeWidgets.dart';
import '../style/styles.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, ThemeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(AppLocalizations.of(context)!.settings),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(AppLocalizations.of(context)!.chooseThemeText,
                  style: Style.settingsText),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: ThemeSwitcher(),
            ),
            Text(AppLocalizations.of(context)!.chooseColorText,
                style: Style.settingsText),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: PrimaryColorSwitcher(),
            ),
            Text(AppLocalizations.of(context)!.chooseLangageText,
                style: Style.settingsText),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: LangageSwitcher(),
            ), //lanageSwitcher
          ],
        ),
      );
    });
  }
}
