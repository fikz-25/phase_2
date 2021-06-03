import 'package:phase_1/model/event_model.dart';

abstract class ThirdState {}

class Initial implements ThirdState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class Loading implements ThirdState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class EventLoaded implements ThirdState {
  final List<Event> events;

  const EventLoaded(this.events);

  @override
  List<Object> get props => [events];

  @override
  bool get stringify => true;
}
