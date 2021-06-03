abstract class ThirdEvent {}

class GetEvent implements ThirdEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
