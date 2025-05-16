class CurrentWeather {
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset = DateTime(3000);

  // Constructors
  CurrentWeather({required String city, required String description, required double currentTemp, required DateTime currentTime, required DateTime sunrise, required DateTime sunset}) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunrise = sunrise;
    this.sunset = sunset;
  }

  factory CurrentWeather.fromOpenWeatherData(data) {
    return CurrentWeather(
        city: data['name'],
        description: data['weather'][0]['description'],
        currentTemp: data['main']['temp'],
        currentTime: DateTime.fromMillisecondsSinceEpoch(data['dt'].toInt() * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'].toInt() * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'].toInt() * 1000));
  }

  // Properties
  String get city {
    return _city;
  }

  set city(String value) {
    if (value.trim().isEmpty) {
      throw Exception('City cannot be empty');
    }

    _city = value;
  }

  String get description {
    return _description;
  }

  set description(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Description cannot be empty');
    }

    _description = value;
  }

  double get currentTemp {
    return _currentTemp;
  }

  set currentTemp(double value) {
    if (value > 100 || value < -100) {
      throw Exception('Temperature must be between -100 and 100');
    }

    _currentTemp = value;
  }

  DateTime get currentTime {
    return _currentTime;
  }

  set currentTime(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }

    _currentTime = value;
  }

  DateTime get sunrise {
    return _sunrise;
  }

  set sunrise(DateTime value) {
    if (value.day != currentTime.day) {
      throw Exception('Sunrise must be on the same day as current time');
    }

    if (value.isAfter(_sunset)) {
      throw Exception('Sunrise cannot be after sunset');
    }

    _sunrise = value;
  }

  DateTime get sunset {
    return _sunset;
  }

  set sunset(DateTime value) {
    if (value.day != currentTime.day) {
      throw Exception('Sunset must be on the same day as current time');
    }

    if (value.isBefore(_sunrise)) {
      throw Exception('Sunset cannot be before sunrise');
    }

    _sunset = value;
  }

  // toString method override
  @override
  String toString() {
    return 'City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset';
  }
}