import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ls_app_firebase_login/constants.dart';
import 'package:ls_app_firebase_login/compontents/rounded_button.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RequiredInfoScreen extends StatefulWidget {
  static const String id = 'requiredInfo_screen';

  @override
  _RequiredInfoScreenState createState() => _RequiredInfoScreenState();
}

class _RequiredInfoScreenState extends State<RequiredInfoScreen> {
  //Map<String, String> selectedValueMap = Map();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String selectedSchool = '';
  String name, surname, schoolName, province, cellNum;
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
      abbreviatedProvince = provinceMap[_selectedProvince];
      schoolList = schoolMap[abbreviatedProvince]['Institution_Name'];
      for (String school in schoolList) {
        schoolItems.add(DropdownMenuItem(child: Text(school)));
      } // add items to schoolItems
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
              child: Text(
                'PLEASE PROVIDE THE FOLLOWING : ',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Select your province: ',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        dropdownColor: Color(0xFFE76F51),
                        iconEnabledColor: Color(0xFFE76F51),
                        iconDisabledColor: Color(0xFFE76F51),
                        items: _dropdownMenuItems,
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                        value: _selectedProvince,
                        onChanged: OnChangedDropdownItem,
                      ),
                    ),
                  ], // Row widgets
                ),
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
              style: TextStyle(color: Colors.white),
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

            TextField(
              style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
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
              title: 'PROCEED',
              onPressed: () {
                //proceed button
              },
            ),
          ],
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
        'Search schools',
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          schoolName = value;
          print(schoolName);
        });
      },
    );
  }
}
