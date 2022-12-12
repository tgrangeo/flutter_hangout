import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/sharedpreferences.dart';
import '../model/themeModels.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});
  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcher();
}

class _ThemeSwitcher extends State<ThemeSwitcher> {
  late bool light;
  late bool check;
  late bool switchDisable = false;
  //bool theme = Provider.of(context, listen: false);

  @override
  void initState() {
    super.initState();
    var prov = Provider.of<ThemeProvider>(context, listen: false);
    if (prov.themeMode == ThemeMode.dark) {
      check = false;
      light = true;
    } else if (prov.themeMode == ThemeMode.system) {
      check = true;
      switchDisable = true;
      light = false;
    } else {
      check = false;
      light = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.sunny,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              Switch(
                  value: light,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Theme.of(context).primaryColor,
                  onChanged: switchDisable == true
                      ? null
                      : (value) {
                          if (value == true) {
                            themeProvider.setSelectedThemeMode(ThemeMode.dark);
                          } else {
                            themeProvider.setSelectedThemeMode(ThemeMode.light);
                          }
                          setState(() {
                            light = value;
                          });
                        }),
              Icon(
                Icons.dark_mode,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              Checkbox(
                  value: check,
                  onChanged: (value) {
                    if (value == true) {
                      themeProvider.setSelectedThemeMode(ThemeMode.system);
                      switchDisable = true;
                      //disable switch
                    } else {
                      late ThemeMode theme;
                      if (light == false) {
                        theme = ThemeMode.light;
                      } else {
                        theme = ThemeMode.dark;
                      }
                      switchDisable = false;
                      themeProvider.setSelectedThemeMode(theme);
                    }
                    setState(() {
                      check = value!;
                    });
                  }),
              const Text("auto"),
            ])
          ],
        ),
      ),
    );
  }
}

class PrimaryColorSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        height: 60,
        width: 360,
        child: GridView.count(
          crossAxisCount: AppColors.primaryColors.length,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          children: List.generate(
            AppColors.primaryColors.length,
            (i) {
              bool _isSelectedColor = AppColors.primaryColors[i] ==
                  themeProvider.selectedPrimaryColor;
              return GestureDetector(
                onTap: _isSelectedColor
                    ? null
                    : () => themeProvider
                        .setSelectedPrimaryColor(AppColors.primaryColors[i]),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColors[i],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isSelectedColor ? 1 : 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
