part of 'dsrm_bloc.dart';

abstract class DSRMEvent extends Equatable {
  const DSRMEvent();
  @override
  List<Object> get props => [];
}

class DSRMEventGetDSRMDetail extends DSRMEvent {



}

class DSRMEventSubmitted extends DSRMEvent {
  final CreateDSRMBody? body;
  const DSRMEventSubmitted(this.body);

}

