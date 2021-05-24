import 'package:bloc_pattern/weather/weather_item.dart';
import 'package:bloc_pattern/weather/weather_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String _city;

  FetchWeatherEvent(this._city);

  @override
  List<Object> get props => [_city];
}

class ResetWeatherEvent extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  WeatherItem _weatherItem;

  WeatherIsLoaded(this._weatherItem);

  WeatherItem get getWeather => _weatherItem;

  @override
  List<Object> get props => [_weatherItem];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherState get initialState => WeatherIsNotSearched();

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherIsLoading();

      try {
        WeatherItem item = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(item);
      } catch (error) {
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeatherEvent) {
      yield WeatherIsNotSearched();
    }
  }
}
