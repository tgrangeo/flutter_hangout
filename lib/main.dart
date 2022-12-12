import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'model/contact.dart';
import 'model/sharedpreferences.dart';
import 'database/DBhelper.dart';
import 'view/homepage.dart';
import 'view/contactpage.dart';
import 'model/themeModels.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBhelper.database();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider themeProvider, child) {
        return MaterialApp(
          locale: Locale(themeProvider.locale),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('fr', ''),
          ],
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: AppColors.getMaterialColorFromColor(
                themeProvider.selectedPrimaryColor),
            primaryColor: themeProvider.selectedPrimaryColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: AppColors.getMaterialColorFromColor(
                themeProvider.selectedPrimaryColor),
            primaryColor: themeProvider.selectedPrimaryColor,
          ),
          themeMode: themeProvider.selectedThemeMode,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          routes: {
            "home": (context) => HomePage(),
            "contactpage": (context) => const ContactPage()
          },
        );
      })));
}
