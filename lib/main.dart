import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/splash/splash2.dart';

import 'constants/globals/shared_prefs.dart';
import 'notifications/notification_handler.dart';

NotificationServices notificationServices = NotificationServices();
AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  'basic_channel',
  'basic_channel',
  description: 'Description',
  importance: Importance.high,
  showBadge: true,
  playSound: true,
);

FlutterLocalNotificationsPlugin flutterPlugin =
    FlutterLocalNotificationsPlugin();

fn(RemoteMessage message) async {

  log(message.data.toString());
  String t = message.data['content'].toString();
  Map a = jsonDecode(t.toString());
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('basic_channel', 'basic_channel',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  if (a['id'] != null && a['id'] is int) {
    flutterPlugin.show(
      a['id'],
      a['title'].toString(),
      a['body'].toString(),
      platformChannelSpecifics,
      payload: a['payload'].toString(),
    );
  }

}

// bool _sendNotif = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  Platform.isAndroid
      ? flutterPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission()
      : await flutterPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
  await SharedPrefs().init();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {

}
void selectNotification(var payload) async {}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  fn(message);

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {

      fn(initialMessage);
    }
  }

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (event) async {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        if (notification != null && android != null) {
          flutterPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  androidChannel.id,
                  androidChannel.name,
                  channelDescription: androidChannel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
        fn(event);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) async {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        if (notification != null && android != null) {
          flutterPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  androidChannel.id,
                  androidChannel.name,
                  channelDescription: androidChannel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
        fn(event);

      },
    );
    notificationServices.initializeNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            // home: ContactSync(),
            home: SplashScreen()
            );
      },
    );
  }
}
