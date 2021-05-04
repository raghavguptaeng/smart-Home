import 'dart:convert';
import 'package:home/client/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/constants.dart';
import 'package:home/private.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var opacity = 0.6;
  var devices = {
    "ac": {'status': true},
    "light": {"status": false},
    "tv": {"status": true}
  };
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xffFF9B75),
  ];
  var currTemp = '32';
  var iot = IOT();
  Future<void> GetCurrentTemp() async {
    var url = Uri.parse(WeatherApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        currTemp = jsonDecode(response.body)['main']['temp'].toString();
      });
      print(jsonDecode(response.body)['main']['temp']);
    } else {
      return 'NAn';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kBackgroundImage), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopRow(),
                RoomName(),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Card(
                            opacity: (devices['ac']['status']) ? 1 : 0.6,
                            Child: AcCard(),
                          ),
                          Card(
                            opacity: (devices['light']['status']) ? 1 : 0.6,
                            Child: LightCard(),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Row(
                        children: [
                          Card(
                            opacity: 0.6,
                            Child: CityTemp(),
                          ),
                          Card(
                            Child: TvCard(),
                            opacity: (devices['tv']['status']) ? 1 : 0.6,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Container(
                        margin:EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Column(
                          children: [
                            Text("Monthly bills"),
                            AspectRatio(
                              aspectRatio: 1.70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LineChart(mainData()),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  Column AcCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Room',
          style: ksubheading.copyWith(
              color: (devices['ac']['status']) ? Colors.black : Colors.grey),
        ),
        Text(
          'Temperature',
          style: ksubheading.copyWith(
              color: (devices['ac']['status']) ? Colors.black : Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "23",
              style: TextStyle(fontSize: 50),
            )),
            Image.asset(
              'assets/img/celsius.png',
              width: 40,
            )
          ],
        ),
        CupertinoSwitch(
          value: devices['ac']['status'],
          onChanged: (value) {
            setState(() {
              if (devices['ac']['status'] == true) {
                devices['ac']['status'] = false;
              } else {
                devices['ac']['status'] = true;
              }
            });
          },
          //activeTrackColor: ,
          trackColor: Colors.grey,
          activeColor: Color(0xFFFF9B75),
        ),
      ],
    );
  }

  Column LightCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Room',
          style: ksubheading.copyWith(
              color: (devices['light']['status']) ? Colors.black : Colors.grey),
        ),
        Text(
          'Lights',
          style: ksubheading.copyWith(
              color: (devices['light']['status']) ? Colors.black : Colors.grey),
        ),
        Center(
          child: Image.asset(
            (devices['light']['status'])
                ? 'assets/img/bulbOn.png'
                : 'assets/img/bulbOff.png',
            width: 65,
          ),
        ),
        CupertinoSwitch(
          value: devices['light']['status'],
          onChanged: (value) {
            setState(() {
              if (devices['light']['status'] == true) {
                devices['light']['status'] = false;
              } else {
                devices['light']['status'] = true;
              }
            });
          },
          //activeTrackColor: ,
          trackColor: Colors.grey,
          activeColor: Color(0xFFFF9B75),
        ),
      ],
    );
  }

  Column TvCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Smart TV',
          style: ksubheading.copyWith(
              color: (devices['tv']['status']) ? Colors.black : Colors.grey),
        ),
        Text(
          'Samsung UA5',
          style: ksubheading.copyWith(
              color: (devices['tv']['status']) ? Colors.black : Colors.grey),
        ),
        Center(
          child: Image.asset(
            (devices['tv']['status'])
                ? 'assets/img/tvOn.png'
                : 'assets/img/tvOff.png',
            width: 65,
          ),
        ),
        CupertinoSwitch(
          value: devices['tv']['status'],
          onChanged: (value) {
            setState(() {
              if (devices['tv']['status'] == true) {
                devices['tv']['status'] = false;
              } else {
                devices['tv']['status'] = true;
              }
            });
          },
          //activeTrackColor: ,
          trackColor: Colors.grey,
          activeColor: Color(0xFFFF9B75),
        ),
      ],
    );
  }

  Column CityTemp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Outdoor',
          style: ksubheading.copyWith(color: Colors.grey),
        ),
        Text(
          'Temperature',
          style: ksubheading.copyWith(color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              currTemp,
              style: TextStyle(fontSize: 50),
            )),
            Image.asset(
              'assets/img/celsius.png',
              width: 40,
            )
          ],
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  Widget Child;
  double opacity;
  Card({this.Child, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.20,
        padding: EdgeInsets.only(left: 15),
        child: Child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFF5F5F6),
        ),
      ),
    );
  }
}

class RoomName extends StatelessWidget {
  const RoomName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Living Room',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Good Morning",
                style: ksubheading,
              ),
              Text(
                "Raghav Gupta",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF959495),
                borderRadius: BorderRadius.circular(15)),
            width: 40,
            height: 40,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
