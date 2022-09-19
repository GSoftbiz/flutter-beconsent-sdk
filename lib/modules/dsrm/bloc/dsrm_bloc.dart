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
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_body.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/drsm_form_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';

part 'dsrm_event.dart';

part 'dsrm_state.dart';

class DSRMBloc extends Bloc<DSRMEvent, DSRMState> {
  DSRMBloc({
    required AuthenticationRepository authenticationRepository,
    required UserSession userSession,
  })  : _authenticationRepository = authenticationRepository,
        _userSession = userSession,
        super(const DSRMState()) {
    on<DSRMEventGetDSRMDetail>(_onGetDSRMForm);
    on<DSRMEventSubmitted>(_onSubmit);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserSession _userSession;

  void _onGetDSRMForm(
    DSRMEventGetDSRMDetail event,
    Emitter<DSRMState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    await _authenticationRepository.getDSRMForm().fold(
        (left) => emit(
            state.copyWith(status: FormzStatus.submissionFailure, error: left)),
        (right) => {
              emit(state.copyWith(
                dsrmForm: right,
                event: event,
                status: FormzStatus.submissionSuccess,
              )),
            });
  }

  void _onSubmit(
      DSRMEventSubmitted event,
      Emitter<DSRMState> emit,
      ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    /*
    await _authenticationRepository.createDSRM().fold(
            (left) => emit(
            state.copyWith(status: FormzStatus.submissionFailure, error: left)),
            (right) => {
          emit(state.copyWith(
            event: event,
            status: FormzStatus.submissionSuccess,
          )),
        });

     */
  }
}
