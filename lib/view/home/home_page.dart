import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so_group/bloc/home_bloc/home_bloc.dart';
import 'package:so_group/core/style.dart';
import 'package:so_group/view/home/profile/profile_page.dart';
import 'package:so_group/view/home/widget/navigation_bar.dart';

class HomePage extends StatelessWidget {
  final PageController pageController = PageController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: BlocProvider(
          create: (context) => HomeBloc(),
          child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              ///
              /// My Project Page
              ///
              Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1.0, color: AppColors.grey))),
                    ),
                  )
              ),

              ///
              /// Profile Page
              ///

              ProfilePage()
            ],
          );
  },
),
        ),
        bottomNavigationBar: AppNavigationBar(
          onItemPressed: (index) {
            try {
              pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
              BlocProvider.of<HomeBloc>(context).add(HomeChangePageEvent(pageIndex: index));
            } catch (e) {
              return;
            }
          },
        ));
  }
}
