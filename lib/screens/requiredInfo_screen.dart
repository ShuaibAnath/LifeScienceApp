import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ls_app_firebase_login/screens/dummy_screen.dart';
import 'package:ls_app_firebase_login/screens/registration_screen.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RequiredInfoScreen extends StatefulWidget {
  static const String id = 'requiredInfo_screen';
  final String userGmail;

  RequiredInfoScreen({this.userGmail});

  @override
  _RequiredInfoScreenState createState() => _RequiredInfoScreenState();
}

class _RequiredInfoScreenState extends State<RequiredInfoScreen> {
  String selectedSchool = '';
  String name = '';
  String surname = '';
  String schoolName = '';
  String province = '';
  String cellNum = '';
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  bool tapped = false;
  String _selectedProvince, abbreviatedProvince;
  List schoolList = [];
  Color myColor = Color(0x77FFFFFF);
  List<DropdownMenuItem> schoolItems = [];


  Map<String, dynamic> schoolMap;
  List<String> _provinces = [
    'Eastern Cape',
    'Free State',
    'Gauteng',
    'KwaZulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'Northern Cape',
    'North West',
    'Western Cape'
  ];
  Map<String, String> provinceMap = {
    'Eastern Cape': 'EC',
    'Free State': 'FS',
    'Gauteng': 'GT',
    'KwaZulu-Natal': 'KZN',
    'Limpopo': 'LP',
    'Mpumalanga': 'MP',
    'Northern Cape': 'NC',
    'North West': 'NW',
    'Western Cape': 'WC'
  };

  TextEditingController myController = TextEditingController();



  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_provinces);
    _selectedProvince = _dropdownMenuItems[0].value;
    abbreviatedProvince = 'EC';
    province = 'Eastern Cape';
    parseJsonFromAssets('school/schools.json').then((data) {
      schoolMap = data;

      setState(() {
        abbreviatedProvince = provinceMap[_selectedProvince];
        schoolList = schoolMap[abbreviatedProvince]['Institution_Name'];
        for (String school in schoolList) {
          schoolItems.add(DropdownMenuItem(child: Text(school)));
        } // add items to schoolItems
      });
    });
    super.initState();
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  } // function to get data from the json

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List provinces) {
    List<DropdownMenuItem<String>> items = [];
    for (String province in provinces) {
      items.add(DropdownMenuItem(
        child: Text(province),
        value: province,
      ));
    } // for loop to add each province into list
    return items;
  } // function to concatenate items in dropdown box

  // ignore: non_constant_identifier_names
  OnChangedDropdownItem(String selectedProvince) {
    setState(() {
      schoolItems = [];
      _selectedProvince = selectedProvince;
      province = selectedProvince;
      abbreviatedProvince = provinceMap[_selectedProvince];
      schoolList = schoolMap[abbreviatedProvince]['Institution_Name'];
      for (String school in schoolList) {
        schoolItems.add(DropdownMenuItem(child: Text(school)));
      } // add items to schoolItems
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Please make sure you have selected your school and entered your name and surname'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF264653),
      appBar: AppBar(
        backgroundColor: Color(0xFFE76F51),
        title: Text('STUDENT DETAILS'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Select your province : ',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      DropdownButton(
                        dropdownColor: Color(0xFFE76F51),
                        iconEnabledColor: Color(0xFFE76F51),
                        iconDisabledColor: Color(0xFFE76F51),
                        items: _dropdownMenuItems,
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                        value: _selectedProvince,
                        onChanged: OnChangedDropdownItem,
                      ),
                    ], // Row widgets
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Required',
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ]),
                ),
              ),
              getSearchableDropdown(schoolList),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Required',
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ]),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                  hintText: 'YOUR NAME',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ), //name

              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Required',
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ]),
                ),
              ),

              TextFormField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  surname = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                  hintText: 'YOUR SURNAME',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Optional',
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    cellNum = value;
                    //Do something with the user input.
                  },
                  decoration: kTextfieldDecoration.copyWith(
                    hintText: 'YOUR CELLPHONE NUMBER',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ), //surname
              RoundedButton(
                colour: Color(0xFFE9C46A),
                title: (widget.userGmail == '') ? 'PROCEED':'REGISTER',
                onPressed: () {
                  if (name.isEmpty ||
                      (name == null) ||
                      (surname == null) ||
                      (schoolName == null) ||
                      (surname.isEmpty) ||
                      (schoolName.isEmpty)) {
                    _showMyDialog();
                  }// if Details incomplete
                  if (cellNum.isEmpty || (cellNum == null)) {
                    cellNum = '0000000000';
                  }// if cellNum is empty
                  else {
                    if(widget.userGmail == '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegistrationScreen(
                                  name: name,
                                  surname: surname,
                                  schoolName: schoolName,
                                  province: province,
                                  cellNum: cellNum,
                                )),
                      );
                    }// if Proceed button
                    else{
                      firestore.collection('users').add({
                        'email': widget.userGmail,
                        'name': name,
                        'surname': surname,
                        'schoolName': schoolName,
                        'province': province,
                        'cellNumber': cellNum,
                      });
                      Navigator.pushNamed(context, DummyScreen.id);
                    }// else register button
                  }// else proceed button actions onPressed
                },
              ),

              // RoundedButton(
              //   colour: Color(0xFFE9C46A),
              //   title: 'REGISTER',
              //   onPressed: () {
              //     if (name.isEmpty ||
              //         (name == null) ||
              //         (surname == null) ||
              //         (schoolName == null) ||
              //         (surname.isEmpty) ||
              //         (schoolName.isEmpty)) {
              //       _showMyDialog();
              //     }
              //     if (cellNum.isEmpty || (cellNum == null)) {
              //       cellNum = '0000000000';
              //     } else {
              //       firestore.collection('users').add({
              //         'email': widget.userGmail,
              //         'name': name,
              //         'surname': surname,
              //         'schoolName': schoolName,
              //         'province': province,
              //         'cellNumber': cellNum,
              //       });
              //       Navigator.pushNamed(context, DummyScreen.id);
              //     }// if else proceed button actions onPressed
              //   },
              // ),


            ],
          ),
        ),
      ),
    );
  }

  //function to generate dropDownSearch
  Widget getSearchableDropdown(List listData) {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < listData.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(
          listData[i],
          style: TextStyle(color: Colors.white),
        ),
        value: listData[i],
      ));
    }
    return SearchableDropdown(
      menuBackgroundColor: Color(0xFFF4A261),
      iconEnabledColor: Color(0xFFE76F51),
      iconDisabledColor: Color(0xFFE76F51),
      isExpanded: true,
      items: items,
      isCaseSensitiveSearch: false,
      hint: Text(
        'Select your school',
        style: TextStyle(color: Colors.white),
      ),
      searchHint: Text(
        'Search Schools',
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          schoolName = value;
        });
      },
    );
  }
}
