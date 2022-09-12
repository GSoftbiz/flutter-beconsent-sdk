part of 'consent_bloc.dart';

abstract class ConsentEvent extends Equatable {
  const ConsentEvent();
  @override
  List<Object> get props => [];
}

class ConsentEventGetConsentDetail extends ConsentEvent {
}

class ConsentEventGetMyConsent extends ConsentEvent {
}



class LoginEventPhoneNumberChanged extends ConsentEvent {
  final String phoneNumber;
  const LoginEventPhoneNumberChanged(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class LoginEventRequestOTP extends ConsentEvent {
  final String callingCode;
  const LoginEventRequestOTP(this.callingCode);
}
