import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Dark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(),
    );
  }
}

class Dpage extends StatefulWidget {
  final String title;

  const Dpage({Key key, this.title}) : super(key: key);

  @override
  DpageState createState() => DpageState();
}

class DpageState extends State<Dpage> {
  bool darkmode = false;
  dynamic savedThemeMode;
  String iconAdress;

  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('thème sombre');
      setState(() {
        darkmode = true;
        iconAdress = 'assets/icon/dark-icon.png';
      });
    } else {
      print('thème clair');
      setState(() {
        darkmode = false;
        iconAdress = 'assets/icon/ligth-icon.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              child: iconAdress != null ? Image.asset(iconAdress) : Container(),
            ),
            SizedBox(height: 70),
            Text(
              'Changez de thème',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: Text(
                "Vous pouvez changer le thème de l'interface de votre application.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Mode sombre'),
              activeColor: Colors.orange,
              secondary: const Icon(Icons.nightlight_round),
              value: darkmode,
              onChanged: (bool value) {
                print(value);
                if (value == true) {
                  AdaptiveTheme.of(context).setDark();
                  iconAdress = 'assets/icon/dark-icon.png';
                } else {
                  AdaptiveTheme.of(context).setLight();
                  iconAdress = 'assets/icon/ligth-icon.png';
                }
                setState(() {
                  darkmode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
