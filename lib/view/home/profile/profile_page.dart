import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:so_group/core/style.dart';
import 'package:so_group/view/home/profile/edit/profile_edit.dart';

import '../../../bloc/profile_bloc/profile_bloc.dart';
import 'edit_components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leadingWidth: size.width / 2.8,
        backgroundColor: AppColors.white,
        elevation: 1,
        title: const Text(
          "Аккаунт",
          style: AppTextStyle.bodyBold,
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {},
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 4),
              Image.asset("assets/icons/arrow_back.png"),
              const SizedBox(width: 8),
              Text(
                "Мой аккаунт",
                style: AppTextStyle.callout.copyWith(color: AppColors.blue),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileLoadUser()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadedState) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),

                      ///
                      /// Avatar
                      ///
                      ///
                      GestureDetector(
                        onTap: () async {
                          final bottomSheetResult =
                              await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      title: const Text(
                                        "Выберите фото",
                                        style: AppTextStyle.footNoteText,
                                      ),
                                      cancelButton: CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Закрыть',
                                              style: AppTextStyle.t3Bold,
                                          )),
                                      actions: [
                                        CupertinoActionSheetAction(
                                            onPressed: () async {
                                              final ImagePicker picker = ImagePicker();

                                              final XFile? cameraPhoto =
                                                  await picker.pickImage(
                                                      source: ImageSource.camera
                                                  );

                                              if (cameraPhoto == null) {
                                                return;
                                              }

                                              if (context.mounted) {
                                                Navigator.of(context).pop(cameraPhoto.path);
                                              }
                                            },
                                            child: const Text('Камера',
                                                style: AppTextStyle.t3)),
                                        CupertinoActionSheetAction(
                                            onPressed: () async {
                                              final ImagePicker picker = ImagePicker();

                                              final XFile? image = await picker.pickImage(
                                                source: ImageSource.gallery,
                                              );

                                              if (image == null) {
                                                return;
                                              }

                                              if (context.mounted) {
                                                Navigator.of(context).pop(image.path);
                                              }
                                            },
                                            child: const Text(
                                              'Галерея Фото',
                                              style: AppTextStyle.t3,
                                            )),
                                      ],
                                    );
                                  });

                          if (bottomSheetResult == null) {
                            return;
                          }

                          if (context.mounted) {
                            BlocProvider.of<ProfileBloc>(context).add(
                                ChangeUserImageEvent(
                                    newDirUrl: bottomSheetResult,
                                ),
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 73,
                              height: 76,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                backgroundImage: state.user.imageUrl != null
                                    ? FileImage(File(state.user.imageUrl!))
                                    : null,
                                child: state.user.imageUrl == null
                                    ? Image.asset(
                                        "assets/icons/img.png",
                                      )
                                    : null,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                "assets/icons/dots.png",
                                scale: 1.05,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      ///
                      ///  Email
                      ///
                      Text(
                        state.user.email ?? "apollo@gmail.com",
                        style: AppTextStyle.caption1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      ///
                      /// User Data
                      ///
                      ProfileEditComponents(
                        name: state.user.name,
                        surName: state.user.surname,
                        onNameEdit: () async {
                          final result = await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProfileEditPage(
                              profileEditingUnit: ProfileEditingUnit.name,
                              previousValue: state.user.name,
                            );
                          }));

                          if (result == null) {
                            return;
                          }
                          if (context.mounted) {
                            context
                                .read<ProfileBloc>()
                                .add(ChangeUserNameEvent(newName: result));
                          }
                        },
                        onSurNameEdit: () async {
                          final result = await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProfileEditPage(
                              profileEditingUnit: ProfileEditingUnit.surname,
                              previousValue: state.user.surname,
                            );
                          }));

                          if (result == null) {
                            return;
                          }
                          if (context.mounted) {
                            context.read<ProfileBloc>().add(
                                ChangeUserSurnameEvent(newSurname: result));
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryYellow,
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
