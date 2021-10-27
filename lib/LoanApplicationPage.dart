import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycredit_loans/FinalizationPage.dart';

class LoanApplicationPage extends StatefulWidget {
  @override
  _LoanApplicationPageState createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  String _input = '';
  final _formKey = GlobalKey<FormState>();
  double _value = 100.0;
  int _selectedCategory = 1;
  double monthlyRate = 0.0;
  String _phone = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _calculateMonthlyRate(_value, _selectedCategory);
  }

  _calculateMonthlyRate(double value, int selectedCategory) {
    setState(() {
      monthlyRate =
          (value / _selectedCategory) + (value / _selectedCategory) * 0.01;
    });
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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                          'Tell us \nabout your loan',
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Colors.black87,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'How much do you want?',
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              letterSpacing: .5,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Slider(
                          min: 100.0,
                          max: 1000.0,
                          value: _value,
                          divisions: 18,
                          label: '$_value Eur',
                          onChanged: (dynamic value) {
                            setState(() {
                              _value = value;
                            });
                            _calculateMonthlyRate(value, _selectedCategory);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'How long will it take you to pay back?',
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
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
                        Wrap(
                          children: [
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _selectedCategory == 1
                                      ? Colors.green
                                      : Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedColor: Color(0xffe7f9f6),
                              label: Text(
                                '1 Month',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              selected: _selectedCategory == 1 ? true : false,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedCategory = 1;
                                });
                                _calculateMonthlyRate(
                                    _value, _selectedCategory);
                              },
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Colors.grey[100],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _selectedCategory == 3
                                      ? Colors.blueGrey
                                      : Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedColor: Color(0xffe7f9f6),
                              label: Text(
                                '3 Months',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              selected: _selectedCategory == 3 ? true : false,
                              onSelected: (bool selected) {
                                setState(
                                  () {
                                    _selectedCategory = 3;
                                  },
                                );
                                _calculateMonthlyRate(
                                    _value, _selectedCategory);
                              },
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Colors.grey[100],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _selectedCategory == 6
                                      ? Colors.green
                                      : Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedColor: Color(0xffe7f9f6),
                              label: Text(
                                '6 Months',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              selected: _selectedCategory == 6 ? true : false,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedCategory = 6;
                                });
                                _calculateMonthlyRate(
                                    _value, _selectedCategory);
                              },
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Colors.grey[100],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _selectedCategory == 12
                                      ? Colors.green
                                      : Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedColor: Color(0xffe7f9f6),
                              label: Text(
                                '1 Year',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              selected: _selectedCategory == 12 ? true : false,
                              onSelected: (bool selected) {
                                setState(() {
                                  _selectedCategory = 12;
                                });
                                _calculateMonthlyRate(
                                    _value, _selectedCategory);
                              },
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Colors.grey[100],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Calculations',
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Amount:',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$_value eur',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Time of payment:',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$_selectedCategory months',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Monthly repayment:',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '€ ${monthlyRate.toStringAsFixed(2)} / month',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 48.0,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => FinalizationPage(
                                      amount: _value,
                                      months: _selectedCategory,
                                      monthlyRate:
                                          monthlyRate.toStringAsFixed(2),
                                    ),
                                  ),
                                );
                              } else {
                                var snackBar = SnackBar(
                                  content: Text(
                                    'Enter a valid number!',
                                    textAlign: TextAlign.center,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Apply Now',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color(0xff225675),
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
