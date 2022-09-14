part of 'consent_bloc.dart';

class ConsentState extends Equatable {
  final FormzStatus status;
  final GetConsentDetailResponse? consentDetail;
  final SubmitConsentResponse? consentSubmitted;
  final GetMyConsentResponse? consented;
  final NetworkError? error;
  final ConsentEvent? event;

  const ConsentState(
      {this.status = FormzStatus.pure,
      this.consentDetail,
      this.error,
      this.consentSubmitted,
      this.consented,
      this.event});

  ConsentState copyWith({
    FormzStatus? status,
    GetConsentDetailResponse? consentDetail,
    SubmitConsentResponse? consentSubmitted,
    GetMyConsentResponse? consented,
    NetworkError? error,
    ConsentEvent? event,
  }) {
    return ConsentState(
        status: status ?? this.status,
        consentDetail: consentDetail ?? this.consentDetail,
        consentSubmitted: consentSubmitted ?? this.consentSubmitted,
        consented: consented?? this.consented,
        error: error,
        event: event);
  }

  @override
  List<Object> get props => [status];
}
