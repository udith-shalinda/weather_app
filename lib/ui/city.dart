import 'package:flutter/material.dart';

import './weather.dart';

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  var _cityName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("City"),
        backgroundColor: Colors.redAccent,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/cover.jpg',
              width: 459,
              height: 1250,
              fit: BoxFit.cover,
            ),
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  controller: _cityName,
                  decoration: new InputDecoration(
                      labelText: "Enter the city"
                  ),
                ),
              ),
              new ListTile(
                  title: new RaisedButton(
                      child: new Text("Weather"),
                      onPressed: (){
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context){
                              return new Weather(city:_cityName.text);
                            });
                        Navigator.of(context).push(router);
                      })
              )
            ],
          )
        ],
      )
    );
  }
}
