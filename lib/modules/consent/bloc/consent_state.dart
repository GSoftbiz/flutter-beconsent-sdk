part of 'consent_bloc.dart';

class ConsentState extends Equatable {
  final FormzStatus status;
  final ConsentDetail? consentDetail;
  final NetworkError? error;
  final ConsentEvent? event;

  const ConsentState({
    this.status = FormzStatus.pure,
    this.consentDetail,
    this.error,
    this.event
  });

  ConsentState copyWith({
    FormzStatus? status,
    ConsentDetail? consentDetail,
    NetworkError? error,
    ConsentEvent? event,
  }) {
    return ConsentState(
        status: status ?? this.status,
        consentDetail: consentDetail,
        error: error,
        event:event);
  }

  @override
  List<Object> get props => [status];
}
