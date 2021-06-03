import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phase_1/model/user_model.dart';
import 'package:phase_1/repositories/user_repository.dart';
import 'package:phase_1/ui/fourthScreen/bloc/fourth_event.dart';
import 'package:phase_1/ui/fourthScreen/bloc/fourth_state.dart';

class FourthBloc extends Bloc<FourthEvent, FourthState> {
  final UserRepository userRepository;
  FourthBloc(this.userRepository) : super(Initial());

  @override
  Stream<FourthState> mapEventToState(FourthEvent event) async* {
    if (event is GetAll) {
      yield* _getAllUsers();
      List<Data> data = await userRepository.getUser();
      yield UserLoaded(data);
    }
  }

  Stream<FourthState> _getAllUsers() async* {
    try {
      yield Loading();
    } catch (e) {
      print(e);
    }
  }
}
