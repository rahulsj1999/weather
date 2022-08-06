import 'package:flutter/material.dart';
import 'package:weatherapp/data_service.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  String? cityName;
  String? description;
  double? temperature;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search')),
                Column(
                  children: [
                    Text("city=$cityName"),
                    Text("Temperature=$temperature"),
                    Text("Description=$description"),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
     cityName=response.cityName;
     temperature=response.tempInfo?.temperature;
     description=response.weatherInfo?.description;

    });
  }
}

