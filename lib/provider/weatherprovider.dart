import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
    String apiKey = '';//Add your OpenWeatherMap API key here
    String units = 'metric';
    String _city = 'Thrissur';//Default city
    String get city => _city;
    

    Map<String, dynamic> _weatherData = {};
    Map<String, dynamic> get weatherData => _weatherData;

    Future<void> fetchWeatherData() async{
        final url =  Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$_city&units=$units&appid=$apiKey');
        
        try{
            final response = await http.get(url);

            if(response.statusCode == 200){
                _weatherData = json.decode(response.body);
                //print(_weatherData);
                notifyListeners();
            }else{
                print('Failed to load weather data: ${response.statusCode}');
            }
        } catch (error) {
            print('Error fetching weather data: $error');
        }
    }

    void setCity(String city) {
        _city = city;
        notifyListeners();
    }

    String getTemperature(){
        if(_weatherData.isNotEmpty){
            return _weatherData['main']['temp'].toString();
        }
        return 'N/A';
    }

    String getWeatherCondition(){
        if(_weatherData.isNotEmpty){
            return _weatherData['weather'][0]['description'].toString();
        }
        return 'N/A';
    }
    String getCurentCity(){
        if(_weatherData.isNotEmpty){
            return _weatherData['name'].toString();
        }
        return 'N/A';
    }
    String getMaxTemperature(){
        if(_weatherData.isNotEmpty){
            return _weatherData['main']['temp_max'].toString();
        }
        return 'N/A';
    }
    String getMinTemperature(){
        if(_weatherData.isNotEmpty){
            return _weatherData['main']['temp_min'].toString();
        }
        return 'N/A';
    }
    String getIconName(){
        if(_weatherData.isNotEmpty){
            return _weatherData['weather'][0]['icon'].toString();
        }
        return 'N/A';
    }

    
}