import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phase_1/model/event_model.dart';
import 'package:phase_1/repositories/event_repository.dart';
import 'package:phase_1/ui/thirdScreen/bloc/third_event.dart';
import 'package:phase_1/ui/thirdScreen/bloc/third_state.dart';

class ThirdBloc extends Bloc<ThirdEvent, ThirdState> {
  final EventRepository eventRepository;
  ThirdBloc(this.eventRepository) : super(Initial());

  @override
  Stream<ThirdState> mapEventToState(ThirdEvent event) async* {
    if (event is GetEvent) {
      yield* _getEvents();
      List<Event> data = await eventRepository.getEvents();
      print(data.length);
      yield EventLoaded(data);
    }
  }

  Stream<ThirdState> _getEvents() async* {
    try {
      yield Loading();
    } catch (e) {
      print(e);
    }
  }
}
