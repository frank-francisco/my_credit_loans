import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoanVerificationPage extends StatefulWidget {
  final double amount;
  final int months;
  final String monthlyRate;
  final String fullName;
  final String jobStatus;
  final double monthlyIncome;

  LoanVerificationPage(
      {required this.amount,
      required this.months,
      required this.monthlyRate,
      required this.fullName,
      required this.jobStatus,
      required this.monthlyIncome});

  @override
  _LoanVerificationPageState createState() => _LoanVerificationPageState(
      amount: amount,
      months: months,
      monthlyRate: monthlyRate,
      fullName: fullName,
      jobStatus: jobStatus,
      monthlyIncome: monthlyIncome);
}

class _LoanVerificationPageState extends State<LoanVerificationPage> {
  double amount;
  int months;
  String monthlyRate;
  String fullName;
  String jobStatus;
  double monthlyIncome;
  _LoanVerificationPageState(
      {required this.amount,
      required this.months,
      required this.monthlyRate,
      required this.fullName,
      required this.jobStatus,
      required this.monthlyIncome});

  bool loading = true;
  bool isGoodScore = false;
  double score = 0.0;
  String errorMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    calculateScore();
    super.initState();
  }

  Future<String> calculateScore() async {
    var response = await http.get(
      Uri.parse("http://api.mathjs.org/v4/?expr=$monthlyIncome%2F$monthlyRate"),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        loading = false;
      });
      print(body);
      if (body < 5) {
        ///bad score
        setState(() {
          isGoodScore = false;
          score = body;
        });
      } else if (body >= 5 && body <= 10) {
        /// good score
        setState(() {
          isGoodScore = true;
          score = body;
        });
      } else {
        /// good score
        setState(() {
          isGoodScore = true;
          score = 10.0;
        });
      }
    } else if (response.statusCode == 400) {
      //Bad request
      var body = jsonDecode(response.body);
      setState(() {
        loading = false;
        errorMsg = body;
      });
      print(body);
    }

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black87,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            loading
                ? Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          child: SpinKitSpinningLines(
                            color: Colors.black87,
                            size: 80.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: Center(
                      child: Image(
                        height: MediaQuery.of(context).size.width / 4,
                        //width: 300,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          isGoodScore
                              ? 'assets/images/goodScore.png'
                              : 'assets/images/bad_score.png',
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 120,
            ),
            loading
                ? Text(
                    'Please wait...',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: .5,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    isGoodScore
                        ? 'Congratulations  ${fullName.split(' ').elementAt(0)}'
                        : 'We are sorry ${fullName.split(' ').elementAt(0)}',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                        letterSpacing: .5,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: loading
                  ? Text(
                      "Just give us few seconds \nwhile we finish processing your \ninformation.",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          letterSpacing: .5,
                          height: 1.4,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      isGoodScore
                          ? "We are happy to tell you that, \nyou are qualified for our 1% interest loan."
                          : "We are very sorry to tell you that, \nyou are not qualified for our 1% interest loan.",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          letterSpacing: .5,
                          height: 1.4,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              loading ? '' : "Score: ${score.toStringAsFixed(1)}/10.0",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  letterSpacing: .5,
                  height: 1.4,
                ),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
