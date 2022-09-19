part of 'dsrm_bloc.dart';

class DSRMState extends Equatable {
  final FormzStatus status;
  final DSRMFormResponse? dsrmForm;
  final NetworkError? error;
  final DSRMEvent? event;

  const DSRMState(
      {this.status = FormzStatus.pure, this.error, this.dsrmForm, this.event});

  DSRMState copyWith({
    FormzStatus? status,
    NetworkError? error,
    DSRMFormResponse? dsrmForm,
    DSRMEvent? event,
  }) {
    return DSRMState(
        status: status ?? this.status,
        error: error,
        event: event,
        dsrmForm: dsrmForm??this.dsrmForm);
  }

  @override
  List<Object> get props => [status];
}
