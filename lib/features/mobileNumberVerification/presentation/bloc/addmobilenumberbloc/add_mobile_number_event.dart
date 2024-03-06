abstract class AddMobileNumberEvent {}

class EnterMobileEvent extends AddMobileNumberEvent {
  final String mobile;

  EnterMobileEvent({required this.mobile});
}
