import 'package:phase_1/model/user_model.dart';

abstract class FourthState {}

class Initial implements FourthState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class Loading implements FourthState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class UserLoaded implements FourthState {
  final List<Data> datas;

  const UserLoaded(this.datas);

  @override
  List<Object> get props => [datas];

  @override
  bool get stringify => true;
}
