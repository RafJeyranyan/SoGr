part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationSendSmsEvent extends RegistrationEvent{
  final int? verificationCode;
  final String? phoneNumber;

  const RegistrationSendSmsEvent({
    required this.verificationCode,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [];

}

class RegistrationResendSmsEvent extends RegistrationEvent{
  final int? verificationCode;
  final String? phoneNumber;

  const RegistrationResendSmsEvent({
    required this.verificationCode,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [];

}





class RegistrationGoBackEvent extends RegistrationEvent{

  @override
  List<Object?> get props => [];

}