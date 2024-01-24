import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/style.dart';

class ResendMessage extends StatefulWidget {
  final Function()? onResendPressed;

  const ResendMessage({super.key, this.onResendPressed});

  @override
  State<ResendMessage> createState() => _ResendMessageState();
}

class _ResendMessageState extends State<ResendMessage> {

  late Timer _timer ;
  int start = 60;
  @override
  void initState() {
    super.initState();

    startTimer();

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start <= 0) {
        timer.cancel();
        _timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return start != 0 ? Text("$start сек до повтора отправки кода", style: AppTextStyle.header8,)
    :
    RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Отправить код еще раз",
          style: AppTextStyle.header8
              .copyWith(color: AppColors.primaryYellow),
          recognizer: TapGestureRecognizer()..onTap = () async{
            await widget.onResendPressed?.call();

            start = 5;

            startTimer();
          },
        ));
  }
}
