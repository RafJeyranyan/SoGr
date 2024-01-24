import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();


  Future<bool?>? get areNotificationsEnabled async {
    return await notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }



    Future<bool?> requestPermission() async {
      return await notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }




    initNotification() async{
      if(await notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled() == false){
        await notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      }

      AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("@drawable/ic_stat_fiber_new");



      var initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async{

          }
      );

      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,iOS: initializationSettingsIOS,
      );

      await notificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (notificationsResponse) async{

          });
    }

    notificationDetails(){
      return const NotificationDetails(
          android: AndroidNotificationDetails('channel_id', "channel_name",importance: Importance.max),
          iOS: DarwinNotificationDetails()
      );
    }



    showNotification ({int id = 0,String? title, String? body,String? payload}) async{
      return notificationsPlugin.show(id, title, body, await notificationDetails());
    }
  }


