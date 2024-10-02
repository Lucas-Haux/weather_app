import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api
  final _weatherService = WeatherService('afae2b840b9ceeeb4792ff4edffd2c94');
  Weather? _weather;

  // get weather
  _fetchWeather() async {
    // get city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for ciry
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainConditiion) {
    if (mainConditiion == null) return 'assets/weather/sun_animation.json';

    return 'assets/weather/lighting_raining_animation.json';
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center children vertically
          children: [
            const Icon(
              Icons.location_pin,
              size: 29,
              color: Colors.grey,
            ),
            const SizedBox(height: 1), // Add space between elements
            Flexible(
              child: Text(
                _weather?.cityName ?? "loading city..",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ), // Adjust font size if needed
              ),
            ),
            const SizedBox(height: 120), // Add space between elements
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 400, // Desired width
                height: 400, // Desired height
                child:
                    Lottie.asset(getWeatherAnimation(_weather?.mainConditiion)),
              ),
            ),
            const SizedBox(height: 50), // Add space between elements
            Flexible(
              child: Text(
                '${((_weather?.temperature ?? 0) * 9 / 5 + 32).round()}°',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ), // Adjust font size and weight
              ),
            ),
          ],
        ),
      ),
    );
  }
}
