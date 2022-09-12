import 'package:either_dart/either.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/ConsentDetail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';

part 'consent_event.dart';

part 'consent_state.dart';

class ConsentBloc extends Bloc<ConsentEvent, ConsentState> {
  ConsentBloc({
    required AuthenticationRepository authenticationRepository,
    required UserSession userSession,
  })  : _authenticationRepository = authenticationRepository,
        _userSession = userSession,
        super(const ConsentState()) {
    on<ConsentEventGetConsentDetail>(_onGetConsentDetail);
    //on<ConsentEventGetMyConsent>(_onGetMyConsent);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserSession _userSession;

  void _onGetConsentDetail(
    ConsentEventGetConsentDetail event,
    Emitter<ConsentState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    await _authenticationRepository.getConsentDetail().fold(
        (left) => emit(state.copyWith(
            status: FormzStatus.submissionFailure, error: left)),
        (right) => {
          debugPrint("OKOKOKOK"),
          emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              consentDetail: right,
              event: event))
        });
  }

}
