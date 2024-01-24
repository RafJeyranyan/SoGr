import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:so_group/core/style.dart';

class RegisterPrimaryScreen extends StatelessWidget {
  final Function()? onSendSmsPressed;
  final TextEditingController inputController;

  const RegisterPrimaryScreen(
      {super.key, this.onSendSmsPressed, required this.inputController});

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
          /// Registration Text
          ///
          SizedBox(
            width: size.width / 1.75,
            child: Column(
              children: [
                const Text(
                  "Регистрация",
                  style: AppTextStyle.header1,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("Введите номер телефона для регистрации",
                        style: AppTextStyle.header8,
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 38,
          ),

          ///
          /// TextField
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Номер телефона",
                  style: AppTextStyle.header9,
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: inputController,
                    cursorColor: AppColors.grey,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10)
                    ],
                    onChanged: (val) {
                      inputController.text = formatNumber(val, previousText);
                      if (val.length <= 3) {
                        inputController.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: inputController.text.length - 1));
                      }
                      if (previousText.length > val.length) {}

                      previousText = val;
                    },
                    style: AppTextStyle.body1,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      // isDense: true,
                      enabledBorder: OutlineInputBorder(
                          gapPadding: 2,
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColors.lightGrey)),
                      border: OutlineInputBorder(
                          gapPadding: 2,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 2,
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: AppColors.primaryYellow)),

                      prefixIconConstraints:
                          const BoxConstraints(maxWidth: 44, maxHeight: 20),

                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "+7",
                            style: AppTextStyle.body1,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 120,
          ),

          ///
          /// SendMessage button
          ///
          SizedBox(
            width: size.width / 1.31,
            child: Column(
              children: [
                SizedBox(
                  height: 53,
                  child: ValueListenableBuilder(
                    valueListenable: inputController,
                    builder: (context, val, child) {
                      return Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: val.text.length < 15
                                ? AppColors.grey
                                : AppColors.primaryYellow),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18.0),
                          onTap: val.text.length == 15
                              ? () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                  onSendSmsPressed?.call();
                                }
                              : null,
                          child: const Center(
                            child: Text(
                              "Отправить смс-код",
                              style: AppTextStyle.button,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),

                ///
                /// Privacy policy
                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                            text:
                                "Нажимая на данную кнопку, вы даете \nсогласие на обработку ",
                            style: AppTextStyle.caption),
                        TextSpan(
                            text: "персональных данных",
                            style: AppTextStyle.caption
                                .copyWith(color: AppColors.primaryYellow),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              print("Privacy policy taped");
                            },
                        )

                      ])),
                )
              ],
            ),
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
