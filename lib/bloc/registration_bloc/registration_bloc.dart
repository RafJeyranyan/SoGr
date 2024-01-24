
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {



  RegistrationBloc() : super(const RegistrationInitial(pageIndex: 0)) {
    on<RegistrationEvent>((event, emit) {

    });


    ///
    /// Send sms
    ///
    on<RegistrationSendSmsEvent>((event,emit){
        // emit(RegistrationInitial(pageIndex: state.pageIndex + 1));
      emit(RegistrationConfirmationState(pageIndex: state.pageIndex + 1, phoneNumber: event.phoneNumber ?? "", confirmCode: event.verificationCode ?? -1));

    });


    ///
    /// Resend sms
    ///
    on<RegistrationResendSmsEvent>((event,emit){
        emit(RegistrationConfirmationState(pageIndex: state.pageIndex, phoneNumber: event.phoneNumber ?? "", confirmCode: event.verificationCode ?? -1));
    });



    /// Go back
    on<RegistrationGoBackEvent>((event,emit){
        if(state.pageIndex <= 0){
          return;
        }
        emit(RegistrationInitial(pageIndex: state.pageIndex - 1));

    });
  }
}
