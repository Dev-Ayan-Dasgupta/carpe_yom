import 'dart:convert';

class MobileNumberVerificationArgumentEntity {
  final bool isBusiness;
  final bool isUpdate;
  final bool isReKyc;
  MobileNumberVerificationArgumentEntity({
    required this.isBusiness,
    required this.isUpdate,
    required this.isReKyc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isBusiness': isBusiness,
      'isUpdate': isUpdate,
      'isReKyc': isReKyc,
    };
  }

  factory MobileNumberVerificationArgumentEntity.fromMap(
      Map<String, dynamic> map) {
    return MobileNumberVerificationArgumentEntity(
      isBusiness: map['isBusiness'] as bool,
      isUpdate: map['isUpdate'] as bool,
      isReKyc: map['isReKyc'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MobileNumberVerificationArgumentEntity.fromJson(String source) =>
      MobileNumberVerificationArgumentEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  MobileNumberVerificationArgumentEntity copyWith({
    bool? isBusiness,
    bool? isUpdate,
    bool? isReKyc,
  }) {
    return MobileNumberVerificationArgumentEntity(
      isBusiness: isBusiness ?? this.isBusiness,
      isUpdate: isUpdate ?? this.isUpdate,
      isReKyc: isReKyc ?? this.isReKyc,
    );
  }

  @override
  String toString() =>
      'VerifyMobileArgumentModel(isBusiness: $isBusiness, isUpdate: $isUpdate, isReKyc: $isReKyc)';

  @override
  bool operator ==(covariant MobileNumberVerificationArgumentEntity other) {
    if (identical(this, other)) return true;

    return other.isBusiness == isBusiness &&
        other.isUpdate == isUpdate &&
        other.isReKyc == isReKyc;
  }

  @override
  int get hashCode =>
      isBusiness.hashCode ^ isUpdate.hashCode ^ isReKyc.hashCode;
}
