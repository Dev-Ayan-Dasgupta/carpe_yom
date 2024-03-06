abstract class IdVerificationState {}

class EidVerificationInitState extends IdVerificationState {}

class EidScanningState extends IdVerificationState {}

class EidBothSidesNotScannedState extends IdVerificationState {}

class EidWrongIdTypeScannedState extends IdVerificationState {}

class EidBackScannedFirstState extends IdVerificationState {}

class EidExistsState extends IdVerificationState {}

class EidFrontBackMismatchState extends IdVerificationState {}

class EidExpiredState extends IdVerificationState {}

class EidScanTimedOutState extends IdVerificationState {}

class EidBlockedState extends IdVerificationState {}

class EidMinorState extends IdVerificationState {}

class EidScanSuccessState extends IdVerificationState {}

class EidVerificationSuccessState extends IdVerificationState {}

class EidRegulaErrorState extends IdVerificationState {}
