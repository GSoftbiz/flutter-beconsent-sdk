import 'package:either_dart/either.dart';
import 'package:flutter_beconsent_sdk/core/localization/language_service.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/modules/consent/beconsent.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_response.dart';
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
    on<ConsentEventSubmitConsent>(_onSubmitConsent);
    on<ConsentEventGetMyConsent>(_onGetMyConsent);
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
        (left) => emit(
            state.copyWith(status: FormzStatus.submissionFailure, error: left)),
        (right) => {
              BeConsent.consentDetail = right,
              emit(state.copyWith(
                consentDetail: right,
                event: event,
                status: FormzStatus.submissionSuccess,
              )),
            });
  }

  void _onGetMyConsent(
    ConsentEventGetMyConsent event,
    Emitter<ConsentState> emit,
  ) async {
    emit(state.copyWith(
      event: event,
      status: FormzStatus.submissionInProgress,
    ));
    await _authenticationRepository
        .getMyConsent(GetMyConsentBody(uid: BeConsent.uuid))
        .fold(
            (left) => emit(state.copyWith(
                status: FormzStatus.submissionFailure,
                error: left,
                event: event)),
            (right) => {
                  emit(state.copyWith(
                      status: FormzStatus.submissionSuccess,
                      consented: right,
                      event: event))
                });
  }

  void _onSubmitConsent(
    ConsentEventSubmitConsent event,
    Emitter<ConsentState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    //collect checked purpose's uuid
    List<String> purposeUUIDs = [];
    var i = 0;
    event.purposeChecked.forEach((key, value) {
      if (value) {
        purposeUUIDs.add(state.consentDetail?.purposes[i].uuid ?? "");
      }
      i++;
    });

    //action
    var action = "ALL";
    if (purposeUUIDs.isEmpty) {
      action = "NONE";
    } else if (purposeUUIDs.length < state.consentDetail!.purposes!.length) {
      action = "PARTIAL";
    }
    if (state.consented != null) {
      action = "CHANGE_TO_$action";
    }
    await _authenticationRepository
        .submitConsent(SubmitConsentBody(
            uid: BeConsent.uuid,
            action: action,
            language: LanguageService.defaultLanguage,
            name: BeConsent.consentUserName,
            collectionChannel: state.consentDetail?.collectionChannel,
            consentUUID: state.consentDetail?.consentUUID,
            consentVersion: state.consentDetail?.version,
            purposeUUIDs: purposeUUIDs))
        .fold(
            (left) => emit(state.copyWith(
                status: FormzStatus.submissionFailure, error: left)),
            (right) => {
                  _userSession.saveCollectionChannel(right.collectionChannel),
                  emit(state.copyWith(
                      status: FormzStatus.submissionSuccess,
                      consentSubmitted: right,
                      event: event))
                });
  }
}
