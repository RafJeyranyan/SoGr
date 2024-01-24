import 'package:flutter/material.dart';

import '../../../../core/style.dart';

enum ProfileEditingUnit { name, surname }

class ProfileEditPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final ProfileEditingUnit profileEditingUnit;
  final String? previousValue;

  ProfileEditPage(
      {super.key, required this.profileEditingUnit, this.previousValue});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leadingWidth: size.width / 3,
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Text(
          profileEditingUnit == ProfileEditingUnit.name
              ? "Ваше Имя"
              : profileEditingUnit == ProfileEditingUnit.surname
              ? "Ваша Фамилия"
              : "",
          style: AppTextStyle.bodyBold,
        ),
        centerTitle: true,
        actions: [
          ///
          /// Save button
          ///
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: Row(
              children: [
                Text(
                  "Сохранить",
                  style: AppTextStyle.callout.copyWith(color: AppColors.blue),
                  maxLines: 1,
                ),
              ],
            ),
          )
        ],
        ///
        /// Go Back
        ///
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const SizedBox(width: 4),
              Image.asset("assets/icons/arrow_back.png"),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Аккаунт",
                  style: AppTextStyle.callout.copyWith(color: AppColors.blue),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),

            ///
            /// TextField
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                style: AppTextStyle.callout.copyWith(color: AppColors.darkGrey),
                decoration: InputDecoration(

                    filled: true,
                    hintText: previousValue != null && previousValue != "" ? previousValue : (profileEditingUnit == ProfileEditingUnit.name
                        ? "Ваше Имя"
                        : profileEditingUnit == ProfileEditingUnit.surname
                        ? "Ваша Фамилия"
                        : "") ,
                    hintStyle: AppTextStyle.callout.copyWith(color: previousValue == null ?  AppColors.greyTransparent : const Color(0xFF7D7D7D)),
                    fillColor: AppColors.itemsContrast,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13.0),
                        borderSide: BorderSide.none)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
