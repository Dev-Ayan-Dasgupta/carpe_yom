import 'dart:convert';

class RegistrationArgumentEntity {
  final bool isInitial;
  final bool isUpdateCorpEmail;
  RegistrationArgumentEntity({
    required this.isInitial,
    required this.isUpdateCorpEmail,
  });

  RegistrationArgumentEntity copyWith({
    bool? isInitial,
    bool? isUpdateCorpEmail,
  }) {
    return RegistrationArgumentEntity(
      isInitial: isInitial ?? this.isInitial,
      isUpdateCorpEmail: isUpdateCorpEmail ?? this.isUpdateCorpEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isInitial': isInitial,
      'isUpdateCorpEmail': isUpdateCorpEmail,
    };
  }

  factory RegistrationArgumentEntity.fromMap(Map<String, dynamic> map) {
    return RegistrationArgumentEntity(
      isInitial: map['isInitial'] as bool,
      isUpdateCorpEmail: map['isUpdateCorpEmail'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationArgumentEntity.fromJson(String source) =>
      RegistrationArgumentEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegistrationArgumentEntity(isInitial: $isInitial, isUpdateCorpEmail: $isUpdateCorpEmail)';

  @override
  bool operator ==(covariant RegistrationArgumentEntity other) {
    if (identical(this, other)) return true;

    return other.isInitial == isInitial &&
        other.isUpdateCorpEmail == isUpdateCorpEmail;
  }

  @override
  int get hashCode => isInitial.hashCode ^ isUpdateCorpEmail.hashCode;
}
