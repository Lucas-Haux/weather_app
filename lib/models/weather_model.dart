class Weather {
  final String cityName;
  final double temperature;
  final String mainConditiion;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainConditiion,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainConditiion: json['weather'][0]['main'],
    );
  }
}
