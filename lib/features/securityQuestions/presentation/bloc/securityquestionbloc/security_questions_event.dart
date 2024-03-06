abstract class SecurityQuestionEvent {}

class SecurityQuestionEnableButton extends SecurityQuestionEvent {
  final bool isEnable;
  SecurityQuestionEnableButton(this.isEnable);
}
