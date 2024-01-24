import 'package:flutter/material.dart';

import '../../../core/style.dart';

class ProfileEditComponents extends StatelessWidget {
  final String? name;
  final String? surName;
  final Function()? onNameEdit;
  final Function()? onSurNameEdit;

  const ProfileEditComponents({super.key, this.name, this.surName, this.onNameEdit, this.onSurNameEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///
        ///  Name
        ///
        GestureDetector(
          onTap: () async {
            await onNameEdit?.call();

          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
                color: AppColors.itemsContrast,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                border: Border(
                    bottom:
                    BorderSide(color: AppColors.lightGrey),
                    top: BorderSide(
                        color: AppColors.lightGrey, width: 0),
                    left: BorderSide(
                        color: AppColors.lightGrey, width: 0),
                    right: BorderSide(
                        color: AppColors.lightGrey, width: 0))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Имя',
                    style: AppTextStyle.callout
                        .copyWith(color: AppColors.greyText),
                  ),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints:
                        const BoxConstraints(maxWidth: 200),
                        child: Text(
                          name != null && name != "" ? name! : "Настроить",
                          style: AppTextStyle.callout.copyWith(
                              color: name != null && name != ""
                                  ? const Color(0xFF7D7D7D)
                                  : AppColors.greyTransparent
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Image.asset(
                        'assets/icons/arrow_right.png',
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        ///
        /// Surname
        ///

        GestureDetector(
          onTap: () async {
            await onSurNameEdit?.call();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
                color: AppColors.itemsContrast,
                border: Border(
                  bottom: BorderSide(color: AppColors.lightGrey),
                )),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Фамилия',
                    style: AppTextStyle.callout
                        .copyWith(color: AppColors.greyText),
                  ),
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints:
                        const BoxConstraints(maxWidth: 200),
                        child: Text(
                          surName != null && surName != "" ? surName! : "Настроить",
                          style: AppTextStyle.callout.copyWith(
                              color: surName != null && surName != ""
                                  ? const Color(0xFF7D7D7D)
                                  : AppColors.greyTransparent
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Image.asset('assets/icons/arrow_right.png'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
