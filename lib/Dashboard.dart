import 'package:flutter/material.dart';
import 'ScreenDimensions.dart';
import 'dbhelper.dart';
import 'Constants.dart';


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DashBoardScores> scores;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getScores().then((s) => setState(() {
      scores = s;
      loaded = true;
    }));
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff264653),
      body: loaded ? SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: SizeConfig.safeBlockVertical * 1.3),
              Text(
                "My Dashboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    height: 1,
                    fontSize: SizeConfig.safeBlockVertical * 5,
                    letterSpacing: 2,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Divider(
                color: Colors.white,
                height: 20,
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Row(
                children: [
                  Column(children: [

                  ],),
                  Column(children:[

                  ],),
                  Column(children: [

                  ],),
                ],
              ),
              DataTable(
            columns: [
              DataColumn(label: Text(
                "Topic",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    height: SizeConfig.safeBlockVertical * 0.12,
                    fontSize: SizeConfig.safeBlockVertical * 2,
                    letterSpacing: SizeConfig.safeBlockHorizontal * 0.5,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),),
              DataColumn(label: Text(
                "Average \n Score",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    height: SizeConfig.safeBlockVertical * 0.12,
                    fontSize: SizeConfig.safeBlockVertical * 2,
                    letterSpacing: SizeConfig.safeBlockHorizontal * 0.5,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),),
            ],
            rows:
            scores.map(((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    kTopicNames[element.topic - 1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        height: SizeConfig.safeBlockVertical * 0.12,
                        fontSize: SizeConfig.safeBlockVertical * 1.5,
                        letterSpacing: SizeConfig.safeBlockHorizontal * 0.2,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),), //Extracting from Map element the value
                  DataCell(Center(
                    child: Text(

                      (element.numberPlays !=0) ? '${(((element.sumScore/element.numberPlays)/15)*100).round()} %'
                          : '0'
                      ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          height: SizeConfig.safeBlockVertical * 0.12,
                          fontSize: SizeConfig.safeBlockVertical * 1.5,
                          letterSpacing: SizeConfig.safeBlockHorizontal * 0.2,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                  )
                      ),
                ],
              )),
            ).toList(),

          ),

          ]

        ),
      )
      )
          : Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff264653),
        child: Center(child: new CircularProgressIndicator()),
      )
    );
  }
}
