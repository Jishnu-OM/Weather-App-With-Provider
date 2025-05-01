import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/weatherprovider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WeatherProvider weather;

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context);

    String temperature = weather.getTemperature();
    String weatherCondition = weather.getWeatherCondition();
    String maxTemperature = weather.getMaxTemperature();
    String minTemperature = weather.getMinTemperature();
    String city = weather.getCurentCity();
    String icon = weather.getIconName();
    String date = 'July, 21';
    List<Map<String, String>> hourlyForecasts = [
      {
        'time': '15.00',
        'temp': temperature,
      }, //Because hourly data is not available in the current API(free version),i am using the same temperature for all hours.
      {'time': '16.00', 'temp': temperature},
      {'time': '17.00', 'temp': temperature},
      {'time': '18.00', 'temp': temperature},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          Text(
            city,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.location_on, color: Colors.white, size: 20),
            position: PopupMenuPosition.under,
            onSelected: (String value) {
              weather.setCity(value);
              weather.fetchWeatherData();
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'thrissur',
                  child: Text(
                    'Thrissur',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'kochi',
                  child: Text(
                    'Kochi',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delhi',
                  child: Text(
                    'Delhi',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'london',
                  child: Text(
                    'London',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ];
            },
            color: Colors.transparent,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(27, 36, 69, 1),
              Color.fromRGBO(47, 52, 111, 1),
              Color.fromRGBO(89, 67, 163, 1),
              Color.fromRGBO(103, 75, 170, 1),
              Color.fromRGBO(146, 66, 171, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            // Remove the Expanded widget
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 106),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      iconSelector(icon),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    '  $temperature°',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weatherCondition,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Max: $maxTemperature°',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Min: $minTemperature°',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 85),
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Image.asset(
                      'assets/images/home.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(62, 45, 143, 1),
                    Color.fromRGBO(157, 82, 172, .7),
                  ],
                ),
              ),
              height: 200,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white, thickness: .4, height: 20),
                  SizedBox(height: 18),
                  SizedBox(
                    height: 100, // Adjust height as needed
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // For horizontal scrolling
                      itemCount: hourlyForecasts.length,
                      itemBuilder: (context, index) {
                        final forecast = hourlyForecasts[index];
                        return Padding(
                          // Add padding for spacing
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            children: [
                              Text(
                                '  ${forecast['temp']}°C',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Image.asset(
                                iconSelector(icon),
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                forecast['time']!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String iconSelector(String icon) {
    switch (icon) {
      case '01d':
        return 'assets/icons/sun.png';
      case '02d':
        return 'assets/icons/partlyclouded.png';
      case '03d':
        return 'assets/icons/cloudy.png';
      case '04d':
        return 'assets/icons/cloudy.png';
      case '09d':
        return 'assets/icons/showerrain.png';
      case '10d':
        return 'assets/icons/rain.png';
      case '11d':
        return 'assets/icons/strom.png';
      default:
        return 'assets/icons/sun.png';
    }
  }
}
