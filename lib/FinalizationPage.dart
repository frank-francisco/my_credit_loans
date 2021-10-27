import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mycredit_loans/LoanVerificationPage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FinalizationPage extends StatefulWidget {
  final double amount;
  final int months;
  final String monthlyRate;
  FinalizationPage(
      {required this.amount, required this.months, required this.monthlyRate});

  @override
  _FinalizationPageState createState() => _FinalizationPageState(
      amount: amount, months: months, monthlyRate: monthlyRate);
}

class _FinalizationPageState extends State<FinalizationPage> {
  double amount;
  int months;
  String monthlyRate;
  _FinalizationPageState(
      {required this.amount, required this.months, required this.monthlyRate});

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  File? _imageFile;
  String name = '';
  String jobTitle = '';
  String income = '';
  String imageName = 'Select your latest invoice';
  int? val = 1;
  bool jobTitleVisibility = true;

  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    ///cropping the picked invoice
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        //aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        maxHeight: 1000,
        maxWidth: 1000,
        compressQuality: 80,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(
      () {
        _imageFile = croppedFile;
        imageName = basename(_imageFile!.path);
        print(_imageFile!.lengthSync());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                child: AbsorbPointer(
                  absorbing: _loading,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            'Tell us \nmore about you',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            maxLength: 30,
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                letterSpacing: .5,
                              ),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Your first and last name',
                              contentPadding: const EdgeInsets.all(0.0),
                              errorStyle: TextStyle(color: Colors.brown),
                            ),
                            onChanged: (val) {
                              setState(() => name = val.trim());
                            },
                            validator: (val) =>
                                name.contains(' ') && val!.length > 5
                                    ? null
                                    : ('Enter a valid name'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Occupational status',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: val,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        val = value as int?;
                                        jobTitleVisibility = true;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Employed',
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        letterSpacing: .5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: val,
                                    onChanged: (value) {
                                      setState(() {
                                        val = value as int?;
                                        jobTitleVisibility = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'unemployed',
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        letterSpacing: .5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible: jobTitleVisibility,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                maxLength: 30,
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black54,
                                    letterSpacing: .5,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: 'Job title',
                                  contentPadding: const EdgeInsets.all(0.0),
                                  errorStyle: TextStyle(color: Colors.brown),
                                ),
                                onChanged: (val) {
                                  setState(() => jobTitle = val.trim());
                                },
                                validator: (val) => val!.length > 1
                                    ? null
                                    : ('Enter a valid job title'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            maxLength: 30,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                                letterSpacing: .5,
                              ),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Your monthly income (€)',
                              contentPadding: const EdgeInsets.all(0.0),
                              errorStyle: TextStyle(color: Colors.brown),
                            ),
                            onChanged: (val) {
                              setState(() => income = val.trim());
                            },
                            validator: (val) => val!.isNotEmpty
                                ? null
                                : ('Enter a valid number'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              getImage();
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1.0,
                                    color: Color(0xff1e407c),
                                  ),
                                ),
                                color: Colors.grey[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 4.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selected invoice',
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      imageName,
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                          fontSize: 18.0,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary;
                                  return Color(
                                      0xff1e407c); // Use the component's default.
                                },
                              ),
                            ),
                            //color: Color(0xff1e407c),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_imageFile != null &&
                                  _formKey.currentState!.validate()) {
                                ///If every required information is filled we take the required data to next screen
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => LoanVerificationPage(
                                      amount: amount,
                                      months: months,
                                      monthlyRate: monthlyRate,
                                      fullName: name,
                                      jobStatus:
                                          val == 1 ? 'Employed' : 'Unemployed',
                                      monthlyIncome: double.parse(income),
                                    ),
                                  ),
                                );
                              } else {
                                final snackBar = SnackBar(
                                  content: const Text(
                                    'Please fill everything!',
                                    textAlign: TextAlign.center,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
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
