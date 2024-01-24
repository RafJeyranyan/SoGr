import 'package:flutter/material.dart';
import 'package:so_group/core/style.dart';

class AppNavigationBar extends StatefulWidget {
  final Function(int index)? onItemPressed;

  const AppNavigationBar({super.key, this.onItemPressed});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BottomAppBar(
        color: AppColors.white,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    widget.onItemPressed?.call(0);
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  icon: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      /// Icon grey background
                      Center(
                        child: Container(
                          height: 21,
                          width: 21,
                          decoration: BoxDecoration(
                            color: _currentIndex == 0
                                ? AppColors.blue
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icons/Group.png',
                          color: AppColors.contrast,
                          fit: BoxFit.fill,
                          height: 24,
                          width: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Мои проекты",
                  maxLines: 1,
                  style: AppTextStyle.caption2.copyWith(
                      color:
                          _currentIndex == 0 ? AppColors.blue : AppColors.grey),
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    widget.onItemPressed?.call(1);
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  icon: Center(
                    child: Image.asset(
                      'assets/icons/Frame.png',
                      color:
                          _currentIndex == 1 ? AppColors.blue : AppColors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                Text("Мой аккаунт",
                    maxLines: 1,
                    style: AppTextStyle.caption2.copyWith(
                      color:
                          _currentIndex == 1 ? AppColors.blue : AppColors.grey,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
