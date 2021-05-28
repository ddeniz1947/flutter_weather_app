import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather_class.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'src/env.dart';
void main() {
  runApp(MyApp());
}

class City {
  String name;

  City(this.name);

  factory City.fromJson(dynamic json) {
    return City(json['name'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}}';
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    load();
    httpGetFunc();
    super.initState();
  }

  //ŞEHİRLER LOADER FONKSİYON
  String weatherType = "Clear";
  String day = "";
  String icon = "";
  String description = "";
  String degree = "";
  String date = "";
  String selectedCity = "ANKARA";
  var cityList = <String>[];
  Environment env = new Environment();
  load() async {
    var arrayData = <String>[];
    String jsonStringValues = await rootBundle
        .loadString('assets/cities.json'); // add .json at the end
    var data = jsonDecode(jsonStringValues);
    for (var i = 0; i < data[0]['data'].length; i++) {
      var data2 = data[0]['data'];
      if (data2[i]['sehir_title'].toString() != ',' &&
          data2[i]['sehir_title'].toString() != '') {
        arrayData.add(data2[i]['sehir_title']);
      }
    }

    setState(() {
      cityList = arrayData;
    });
  }

  //HAVA DURUMU HTTP GET
  httpGetFunc() {
    var response = http.get(
        Uri.parse(
            "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$selectedCity"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "apikey " + env.apiKey
        }).then((resp) {
      var weather_resp = jsonDecode(resp.body);
      print(weather_resp['result'][0]['date']);
      print(weather_resp['result'][0]['day']);
      print(weather_resp['result'][0]['description']);
      print(weather_resp['result'][0]['degree']);
      if (weather_resp['result'][0]['status'].toString() != "") {
        setState(() {
          weatherType = weather_resp['result'][0]['status'].toString();
        });
      }
      if (weather_resp['result'][0]['day'].toString() != "") {
        setState(() {
          day = weather_resp['result'][0]['day'].toString();
        });
      }
      if (weather_resp['result'][0]['description'].toString() != "") {
        setState(() {
          description = weather_resp['result'][0]['description'].toString();
        });
      }
      if (weather_resp['result'][0]['degree'].toString() != "") {
        setState(() {
          degree = weather_resp['result'][0]['degree'].toString();
        });
      }
      if (weather_resp['result'][0]['date'].toString() != "") {
        setState(() {
          date = weather_resp['result'][0]['date'].toString();
        });
      }
      print(weatherType);
    });
  }

  //HAVA DURUMU HTTP POST
  httpPostFunc() {
    Weather userData = new Weather(selectedCity: selectedCity, degree: degree.toString(), day:day.toString(),description:description.toString(),date:date.toString());
    String json = jsonEncode(userData);
    http.post(
      Uri.parse(
          "https://flutter-weather-896f3-default-rtdb.firebaseio.com/weather_data.json"),
      headers: {"Content-Type": "application/json"},
      body: json,
    );


  }

  @override
  Widget build(BuildContext context) {
    //load();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: new DropdownButton<String>(
                    value: selectedCity,
                    items: cityList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue.toString();
                      });
                      httpGetFunc();
                    },
                  ),
                ),
                Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset('assets/$weatherType.png'),
                ),
                Text('Tarih : $date',style: TextStyle(fontSize: 20.0),),
                Text('Gün : $day',style: TextStyle(fontSize: 20.0),),
                Text('Açıklama : $description',style: TextStyle(fontSize: 20.0),),
                Text('Derece : $degree',style: TextStyle(fontSize: 20.0),),
                OutlinedButton.icon(
                  label: Text('Seçimi Kaydet',style: TextStyle(fontSize: 20.0),),
                  icon: Icon(Icons.save),
                  onPressed: () {
                    httpPostFunc();
                  },
                )
              ],
            ),
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void saveButton() {
  }
}
