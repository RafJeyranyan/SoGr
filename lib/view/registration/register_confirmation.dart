import 'package:flutter/material.dart';
import 'package:so_group/core/style.dart';
import 'package:so_group/view/registration/widget/pin_code_field.dart';
import 'package:so_group/view/registration/widget/resend_button.dart';


class RegisterConfirmationScreen extends StatelessWidget {
  final Function()? onResendPressed;
  final Function()? onCompleted;
  final String phoneNumber;
  final int confirmationCode;

  final TextEditingController inputController;

  const RegisterConfirmationScreen(
      {super.key, this.onResendPressed, required this.inputController, required this.phoneNumber, required this.confirmationCode, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String previousText = "";

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),

          ///
          /// Confirmation Text
          ///
          SizedBox(
            width: size.width / 1.45,
            child: Column(
              children: [
                const Text(
                  "Подтверждение",
                  style: AppTextStyle.header1,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("Введите код, который мы отправили в SMS на ${phoneNumber ?? ""}",
                        style: AppTextStyle.header8,
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                ///
                /// TextField
                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PinCodeCustomField(
                    onCompleted: (){
                      onCompleted?.call();
                    },
                    inputController: inputController,
                    confirmationCode: confirmationCode,


                  ),
                ),
              ],
            ),
          ),



          const SizedBox(
            height: 44,
          ),

          ///
          ///  Resend button
          ///
         ResendMessage(
           onResendPressed: () async {
             await onResendPressed?.call();
           },

         ),

        ],
      ),
    );
  }

  String formatNumber(String val, String previousText) {
    // if(val.length >= currentInputLength) {
    if (val.length <= 3) {
      return val.replaceAllMapped(RegExp(r'(\d+)'), (Match m) => "(${m[1]})");
    } else if (val.length > 3 && val.length <= 6) {
      return val.replaceAllMapped(
          RegExp(r'(\d{3})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}");
    } else if (val.length > 6 && val.length <= 8) {
      return val.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'),
              (Match m) => "(${m[1]}) ${m[2]} ${m[3]}");
    } else {
      return val.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{2})(\d+)'),
              (Match m) => "(${m[1]}) ${m[2]} ${m[3]} ${m[4]}");
    }

    // }
    // currentInputLength = val.length;
  }
}
