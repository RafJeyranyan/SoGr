import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/style.dart';

class PinCodeCustomField extends StatefulWidget {
  final TextEditingController? inputController;
  final int confirmationCode;
  final Function()? onCompleted;

  const PinCodeCustomField({super.key, this.inputController, required this.confirmationCode, this.onCompleted});

  @override
  State<PinCodeCustomField> createState() => _PinCodeCustomFieldState();
}

class _PinCodeCustomFieldState extends State<PinCodeCustomField> {
  late TextEditingController? textEditingController;

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  @override
  void initState() {
    textEditingController = widget.inputController ?? TextEditingController();
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: textEditingController,
      appContext: context,
      length: 5,
      autoDisposeControllers: false,
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      autoFocus: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      beforeTextPaste: (val){
        try{
          int.parse(val!);
          return true;
        }catch (e){
          return false;
        }
      },
      autovalidateMode: AutovalidateMode.disabled,

      pinTheme: PinTheme(
        inactiveColor: AppColors.grey,
        activeColor: AppColors.grey,
        selectedColor: AppColors.primaryYellow,
      ),

      onCompleted: (val){
        try {
          int enteredCode = int.parse(val);
          if (enteredCode == widget.confirmationCode) {

            widget.onCompleted?.call();

            setState(() {
              hasError = false;
            });
            return ;
          }else {
            errorController!.add(
                ErrorAnimationType.shake); // Triggering error shake animation
            setState(() => hasError = true);
          }
        }catch (e){
          return;
        }
      },
    );
  }
}
