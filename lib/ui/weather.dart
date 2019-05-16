import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../util/utils.dart' as util;

import './city.dart';

class  Weather extends StatefulWidget {
  final String city;
  Weather({Key key,this.city}):super(key :key);

  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> with SingleTickerProviderStateMixin {

  void showWeather() async{
    Map data = await getWeather(util.apiId, "${widget.city}");
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: new Text('Weather'),
        actions: <Widget>[
          new IconButton(
              onPressed: (){
                var router = new MaterialPageRoute(
                    builder: (BuildContext context){
                      return new City();
                    });
                Navigator.of(context).push(router);
              },
              icon: new Icon(Icons.menu),
              )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
                'images/cover.jpg',
                fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: new EdgeInsets.fromLTRB(0, 10, 15, 0),
            child: new Text(
                "${widget.city}",
                style: new TextStyle(
                  fontSize: 34,
                  fontStyle: FontStyle.italic
                ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25, 400, 0, 0),
            child: UpdateTempWidget("${widget.city}"),
          )
        ],
      ),
    );
  }
  Future<Map> getWeather(String appId,String city) async{
    String appUrl ="http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=imperial";
    http.Response response = await http.get(appUrl);

    return json.decode(response.body);
  }

  Widget UpdateTempWidget(String city){
    return new FutureBuilder(
        future: getWeather(util.apiId, city == null ? util.defaultCity:city),
        builder:(BuildContext context,AsyncSnapshot<Map> snapshot){
          if(snapshot.hasData){
            Map content = snapshot.data;
            if(content['main']==null){
              return new Container(
                child: new Text(
                  "The city is not Found!!",
                  style: wetherDetails(),
                ),
              );
            }else{
              return new Container(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title:new Text(
                        content['main']['temp'].toString(),
                        style: wetherDetails(),
                      ),
                    )
                  ],
                ),
              );
            }
          }else{
            return new Container();
          }
        });
  }
}

TextStyle wetherDetails(){
  return new TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 50,
    fontWeight: FontWeight.w800,
    color: Colors.redAccent.shade700
  );
}
