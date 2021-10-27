import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycredit_loans/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      title: 'My Credit Loans',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blueGrey,
        cardColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: SplashScreen(),
    );
  }
}
