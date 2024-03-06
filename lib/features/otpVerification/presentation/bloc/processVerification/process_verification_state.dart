abstract class ProcessVerificationState {}

class OtpInitState extends ProcessVerificationState {}

class OtpSuccessState extends ProcessVerificationState {}

class OtpErrorState extends ProcessVerificationState {}

class TimerRunningState extends ProcessVerificationState {}

class TimerEndState extends ProcessVerificationState {}
