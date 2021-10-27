import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycredit_loans/LoanApplicationPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _controller;
  late Timer _timer;
  bool _animate = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    screenDelay();
    initializeAnimations();
  }

  initializeAnimations() {
    _timer = new Timer(
      const Duration(seconds: 2),
      () {
        print('one');
        setState(() {
          _animate = true;
        });
      },
    );
    _timer = new Timer(
      const Duration(milliseconds: 3400),
      () {
        print('two');
        setState(() {
          showText = true;
        });
      },
    );
  }

  screenDelay() {
    _timer = new Timer(
      const Duration(seconds: 5),
      () {
        print('done');
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => LoanApplicationPage(),
            ),
            (r) => false);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color(0xff225675),
        body: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    // height: 210,
                    height: MediaQuery.of(context).size.width / 1.6,
                  ),
                  Visibility(
                    visible: showText,
                    child: Text(
                      'Loans with low interest',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: .5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              top: _animate
                  ? MediaQuery.of(context).size.height / 4
                  : MediaQuery.of(context).size.height / 2,
              duration: Duration(milliseconds: 600),
              //curve: Curves.decelerate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image(
                    height: 80,
                    //width: 300,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/logo_3.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
