import 'package:flutter/material.dart';

class  Weather extends StatefulWidget {
  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: new Text('Weather'),
        actions: <Widget>[
          new IconButton(
              onPressed: ()=>{
                debugPrint("menu pressed")
              },
              icon: new Icon(Icons.menu),
              )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/cover.jpg'),
          )
        ],
      ),
    );
  }
}
