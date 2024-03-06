// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ProcessVerificationEvent {}

class EnterOtpEvent extends ProcessVerificationEvent {
  final String otp;

  EnterOtpEvent({required this.otp});
}

class OtpTimerEvent extends ProcessVerificationEvent {
  final int seconds;
  OtpTimerEvent({
    required this.seconds,
  });
}

class OtpInitEvent extends ProcessVerificationEvent {}
