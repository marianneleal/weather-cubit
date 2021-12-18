//created automatically when cubit is created with rightclick
//Cubit: New Cubit on a folder

part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  // add const for purposes of premature optimization
  const WeatherState();
}

// initial state before the user has taken any action. just initial searchbar
class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

// want to hold actual state field in weatherLoaded
class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);

// override equality to be a value equality. will add boilerplate
// instead use freezed. has support for unions which as basically subclasses
// on steroids, adds needed value equality automatically
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherLoaded && o.weather == weather;
  }
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
