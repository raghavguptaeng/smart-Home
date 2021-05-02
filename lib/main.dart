import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(init());
}

class init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var opacity = 0.6;
  var devices = {
    "ac":{
      'status':true
    },
    "light":{
      "status":false
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    kBackgroundImage,
                  ),
                  fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopRow(),
                RoomName(),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Card(
                        opacity: (devices['ac']['status'])?1:0.6,
                        Child: AcCard(),
                      ),
                      Card(
                        opacity: (devices['light']['status'])?1:0.6,
                        Child: LightCard(),
                      ),
                      Card(
                        opacity: 1,
                        Child: CityTemp(),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Column AcCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Room',style: ksubheading.copyWith(color:(devices['ac']['status'])?Colors.black:Colors.grey),),
        Text('Temperature',style: ksubheading.copyWith(color:(devices['ac']['status'])?Colors.black:Colors.grey),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(child: Text("23",style: TextStyle(fontSize: 50),)),
            Image.asset('assets/img/celsius.png',width: 40,)
          ],
        ),
        CupertinoSwitch(
          value: devices['ac']['status'],
          onChanged: (value) {
            setState(() {
              if(devices['ac']['status']==true){
                devices['ac']['status'] = false;
              }
              else{
                devices['ac']['status'] = true;
              }
            });
          },
          //activeTrackColor: ,
          trackColor: Colors.red,
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
        Text('Room',style: ksubheading.copyWith(color:(devices['light']['status'])?Colors.black:Colors.grey),),
        Text('Lights',style: ksubheading.copyWith(color:(devices['light']['status'])?Colors.black:Colors.grey),),
        Center(child: Image.asset((devices['light']['status'])?'assets/img/bulbOn.png':'assets/img/bulbOff.png',width: 65,)),
        CupertinoSwitch(
          value: devices['light']['status'],
          onChanged: (value) {
            setState(() {
              if(devices['light']['status']==true){
                devices['light']['status'] = false;
              }
              else{
                devices['light']['status'] = true;
              }
            });
          },
          //activeTrackColor: ,
          trackColor: Colors.red,
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
        Text('Outdoor',style: ksubheading.copyWith(color:(devices['ac']['status'])?Colors.black:Colors.grey),),
        Text('Temperature',style: ksubheading.copyWith(color:(devices['ac']['status'])?Colors.black:Colors.grey),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(child: Text("23",style: TextStyle(fontSize: 50),)),
            Image.asset('assets/img/celsius.png',width: 40,)
          ],
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  Widget Child;
  double opacity;
  Card({this.Child , this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(8),
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
