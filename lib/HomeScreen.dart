import 'package:flutter/material.dart';
import 'HomeScreenClasses.dart';
import 'ScreenDimensions.dart';
import 'Constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff264653),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: SizeConfig.safeBlockVertical * 1.3),
              Text(
                "Understanding Life Sciences",
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
              Text(
                "POWERED BY PULSE EDUCATION",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    height: SizeConfig.safeBlockVertical * 0.12,
                    fontSize: SizeConfig.safeBlockVertical * 1.2,
                    letterSpacing: SizeConfig.safeBlockHorizontal * 0.5,
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
              Text(
                "Scroll & Click on a topic below: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    height: SizeConfig.safeBlockVertical * 0.12,
                    fontSize: SizeConfig.safeBlockVertical * 2,
                    letterSpacing: SizeConfig.safeBlockHorizontal * 0.5,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 4),
              Container(
                width: SizeConfig.safeBlockHorizontal * 90,
                height: SizeConfig.safeBlockVertical * 55,
                child:ExpansionPanelDemo(icons_1: icons_1),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i<buttonsHome.length ; i++)
                    ButtonsHome(buttonText:buttonsHome[i],i:i+1,colour:colorList[i],icons:icons[i]),
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 5),

            ],
          ),
        ),
      ),


    );
  }
}
