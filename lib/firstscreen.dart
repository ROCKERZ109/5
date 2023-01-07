import 'dart:convert';
import 'package:draw_graph/models/feature.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot/sizeConfig.dart';

class FirstScreen extends StatefulWidget {
  static var id = 'FirstScreen';

  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

//BULb-https://cloud.boltiot.com/remote/a39ab95f-19c2-4e2f-8322-af62391b0306/analogRead?deviceName=BOLT13135447&pin=A0
class _FirstScreenState extends State<FirstScreen> {
  String onoff = 'OFF';
  var signal = 'LOW';

  final List<Feature> feature0 = [
    Feature(
      title: "Temperature",
      color: Colors.red,
      data: [.56, .66, .50, 0.40, 0.22, 0.70],
    ),
  ];
  final List<Feature> feature1 = [
    Feature(
      title: "Humidity",
      color: Colors.blue,
      data: [.56, .66, .50, 0.40, 0.22, 0.70],
    ),
  ];
  final List<Feature> feature2 = [
    Feature(
      title: "Moisture",
      color: Colors.yellow,
      data: [.56, .66, .50, 0.40, 0.22, 0.70],
    ),
  ];

  @override
  void initState() {
    CallForTempValue();
    // TODO: implement initState
    super.initState();
  }

  var tempValue;
  bool flag = true;

  void CallForTempValue() async {
      setState(() {
        flag=true;
      });
    var getValue = await http.get(Uri.parse(
        'https://cloud.boltiot.com/remote/a39ab95f-19c2-4e2f-8322-af62391b0306/analogRead?deviceName=BOLT13135447&pin=A0'));
    var data = jsonDecode(getValue.body);
    print(getValue.body);

    if (getValue.statusCode == 200) {
      setState(() {
        tempValue = data['value'];
        flag = false;
      });
    } else {
      setState(() {
        tempValue = 'You have called too many times so please wait!';
        flag = false;
      });
    }
    print(data['value']);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: SizeConfig.safeBlockVertical * 7.5,
        backgroundColor: Color(0xff1e0b35),
        title: Text(
          'Karan\'s IOT',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 25,
              fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: SizeConfig.safeBlockVertical * 92.5,
        width: SizeConfig.safeBlockHorizontal * 100,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Material(
                      elevation: 8.5,
                      color: Color(0xff22252D),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      shadowColor: Colors.white,
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 22.5,
                        width: SizeConfig.safeBlockHorizontal * 40,
                        child: Center(
                          child:Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Moisture Value',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Material(
                      elevation: 8.5,
                      color: Color(0xff22252D),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      shadowColor: Colors.white,
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 22.5,
                        width: SizeConfig.safeBlockHorizontal * 40,
                        child: Center(
                          child: flag
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$tempValue',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: tempValue ==
                                                'You have called too many times so please wait!'
                                            ? 12.5
                                            : tempValue == 'Device is offline'
                                                ? 15
                                                : 70,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 35,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff37697a)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            shadowColor:
                                MaterialStateProperty.all(Colors.white),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500))),
                        onPressed: () {},
                        child: Center(
                          child: Text('Latest Value'),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 35,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff37697a)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            shadowColor:
                                MaterialStateProperty.all(Colors.white),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500))),
                        onPressed: () {

                          CallForTempValue();
                        },
                        child: Center(
                          child: Text('Latest Temp Value'),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 3.5,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 54,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: LineGraph(
                  features: feature0,
                  size: Size(SizeConfig.safeBlockHorizontal * 100, 400),
                  labelX: [
                    'Day 1',
                    'Day 2',
                    'Day 3',
                    'Day 4',
                    'Day 5',
                    'Day 6'
                  ],
                  labelY: ['0', '10', '20', '30', '40', '50'],
                  showDescription: true,
                  graphColor: Colors.white30,
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                  descriptionHeight: 130,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 54,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: LineGraph(
                  features: feature1,
                  size: Size(SizeConfig.safeBlockHorizontal * 100, 400),
                  labelX: [
                    'Day 1',
                    'Day 2',
                    'Day 3',
                    'Day 4',
                    'Day 5',
                    'Day 6'
                  ],
                  labelY: ['0', '10', '20', '30', '40', '50'],
                  showDescription: true,
                  graphColor: Colors.white30,
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                  descriptionHeight: 130,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 54,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: LineGraph(
                  features: feature2,
                  size: Size(SizeConfig.safeBlockHorizontal * 100, 400),
                  labelX: [
                    'Day 1',
                    'Day 2',
                    'Day 3',
                    'Day 4',
                    'Day 5',
                    'Day 6'
                  ],
                  labelY: ['0', '10', '20', '30', '40', '50'],
                  showDescription: true,
                  graphColor: Colors.white30,
                  graphOpacity: 0.2,
                  verticalFeatureDirection: true,
                  descriptionHeight: 130,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
