part of 'consent_bloc.dart';

abstract class ConsentEvent extends Equatable {
  const ConsentEvent();

  @override
  List<Object> get props => [];
}

class ConsentEventGetConsentDetail extends ConsentEvent {}

class ConsentEventGetMyConsent extends ConsentEvent {}

class ConsentEventSubmitConsent extends ConsentEvent {
  final Map<int, bool> purposeChecked;
  final bool guardianChecked;
  final GuardianInformation? guardianInformation;

  const ConsentEventSubmitConsent(this.purposeChecked,this.guardianChecked,this.guardianInformation);

  @override
  List<Object> get props => [purposeChecked,guardianChecked];
}
