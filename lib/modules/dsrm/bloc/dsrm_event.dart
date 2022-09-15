part of 'consent_bloc.dart';

abstract class DSRMEvent extends Equatable {
  const DSRMEvent();
  @override
  List<Object> get props => [];
}

class DSRMEventGetDSRMDetail extends DSRMEvent {}

class DSRMEventSubmitted extends DSRMEvent {}

