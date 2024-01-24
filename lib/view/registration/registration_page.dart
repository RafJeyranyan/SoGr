import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so_group/bloc/registration_bloc/registration_bloc.dart';
import 'package:so_group/core/router/router.dart';
import 'package:so_group/core/service/notification_service/notification.dart';
import 'package:so_group/view/registration/register_confirmation.dart';
import 'package:so_group/view/registration/register_primary.dart';
import 'package:so_group/view/registration/widget/step_bar.dart';

import '../../core/style.dart';

class RegistrationPage extends StatelessWidget {
  final PageController pageController = PageController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.contrast,
            appBar: AppBar(
              backgroundColor: AppColors.contrast,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                    if (state.pageIndex <= 0) {
                      return;
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                    context
                        .read<RegistrationBloc>()
                        .add(RegistrationGoBackEvent());
                    pageController.animateToPage(state.pageIndex - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);

                },
                splashRadius: 18,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Image.asset('assets/icons/Vector.png'),
                ),
              ),
            ),
            body: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: size.width / 1.8,
                    height: size.height / 22.2,
                    child: StepBar(
                      currentIndex: state.pageIndex,
                      pageCount: 3,
                    ),
                  ),
                ),
                Flexible(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      RegisterPrimaryScreen(
                        onSendSmsPressed: () async {
                          NotificationService notificationService =
                          NotificationService();

                          if (await notificationService
                              .areNotificationsEnabled ==
                              false) {
                            if (await notificationService.requestPermission() ==
                                false) {
                              return;
                            }
                          }

                          final int verificationCode =
                              10000 + Random().nextInt(90000);
                          notificationService.showNotification(
                              title: "Код для подтверждения",
                              body: "$verificationCode");

                          if (context.mounted) {
                            context
                                .read<RegistrationBloc>()
                                .add(RegistrationSendSmsEvent(
                              phoneNumber: numberController.text,
                              verificationCode: verificationCode,
                            ));
                          }
                          pageController.animateToPage((state).pageIndex + 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        inputController: numberController,
                      ),
                      RegisterConfirmationScreen(
                        inputController: confirmationController,
                        phoneNumber: (state is RegistrationConfirmationState)
                            ? "+7 ${state.phoneNumber}"
                            : "",
                        confirmationCode:
                            (state is RegistrationConfirmationState)
                                ? state.confirmCode
                                : 0,

                        onCompleted: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
                        },
                        onResendPressed: () async {
                          NotificationService notificationService =
                              NotificationService();

                          if (await notificationService
                                  .areNotificationsEnabled ==
                              false) {
                            if (await notificationService.requestPermission() ==
                                false) {
                              return;
                            }
                          }

                          final int verificationCode =
                              10000 + Random().nextInt(90000);
                          notificationService.showNotification(
                              title: "Код для подтверждения",
                              body: "$verificationCode");

                          if (context.mounted) {
                            context
                                .read<RegistrationBloc>()
                                .add(RegistrationResendSmsEvent(
                                  phoneNumber:
                                      (state is RegistrationConfirmationState)
                                          ? state.phoneNumber
                                          : "",
                                  verificationCode: verificationCode,
                                ));
                          }
                        },
                      ),

                      Container(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
