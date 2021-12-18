//created automatically when cubit is created with rightclick Cubit:
// New Cubit on a folder

import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

// contains logic of getting the weather from the repo and then emitting the states
class WeatherCubit extends Cubit<WeatherState> {
  // prepare for dependency injection: we will need to pass a weatherRepository instance to the weathercubit
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  //method called getWeather: will be operating with weather Repository which returns a future. so also return a future.
  // but a future of void since we don't want to return anything

  Future<void> getWeather(String cityName) async {
    // fetchWeather can throw an exception. so we need to wrap everything in a try catch block.
    try {
      emit(new WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError('Error. Please retry.'));
      // (in actual production code: map numbers to readable messages)
    }
  }
}
