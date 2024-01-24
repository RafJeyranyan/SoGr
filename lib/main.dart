import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:so_group/core/router/router.dart';
import 'package:so_group/view/home/home_page.dart';
import 'package:so_group/view/registration/registration_page.dart';

import 'core/service/notification_service/notification.dart';

void main() {


  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const DSGroupApp());
}

class DSGroupApp extends StatelessWidget {
  const DSGroupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.registration ,
      routes: {
        AppRouter.home : (context) =>  HomePage(),
        AppRouter.registration : (context) => RegistrationPage(),

      },
      // home: RegistrationPage()
    );
  }
}
