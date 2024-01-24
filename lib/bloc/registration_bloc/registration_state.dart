part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  final int pageIndex;
  const RegistrationState({required this.pageIndex});
}

class RegistrationInitial extends RegistrationState {


  const RegistrationInitial({required super.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}


class RegistrationConfirmationState extends RegistrationState {

  final String phoneNumber;
  final int confirmCode;

  const RegistrationConfirmationState({required this.phoneNumber,required this.confirmCode, required super.pageIndex});

  @override
  List<Object> get props => [pageIndex, confirmCode];
}


