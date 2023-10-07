import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swishlist/splash/splash2.dart';

import 'constants/globals/keys.dart';
import 'constants/globals/shared_prefs.dart';
import 'notifications/notification_handler.dart';

NotificationServices notificationServices = NotificationServices();

AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  'basic_channel',
  'basic_channel',
  description: 'Description',
  //groupId: 'basic_channel_group',
  importance: Importance.high,
  showBadge: true,
  playSound: true,
);

FlutterLocalNotificationsPlugin flutterPlugin =
    FlutterLocalNotificationsPlugin();

fn(RemoteMessage message) async {
  //log(message.data['content']['payload']['type'].toString());
  //AwesomeNotifications().createdStream.listen((event) {});
  //AwesomeNotifications().displayedStream.listen((event) {});
  //AwesomeNotifications().dismissedStream.listen((event) {});
  //AwesomeNotifications().setGlobalBadgeCounter(0);
  log(message.data.toString());
  String t = message.data['content'].toString();
  Map a = jsonDecode(t.toString());
  // http.Response response = await http.get(Uri.parse(a['bigPicture']));
  // final bytes = response.bodyBytes;
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('basic_channel', 'basic_channel',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          // styleInformation: BigPictureStyleInformation(
          //           //     ByteArrayAndroidBitmap.fromBase64String(base64Encode(bytes))
          // ),
          ticker: 'ticker');
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  //log(event.data['content']['id'].toString());
  log(a['id']);
  flutterPlugin.show(
    a['id'],
    a['title'].toString(),
    a['body'].toString(),
    platformChannelSpecifics,
    payload: a['payload'].toString(),
  );
  /*if (message.data['content']['payload']['type'].toString() == 'story') {
    Navigator.push(
        _navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (ctx) => DetailsScreen(
                userName: message.data['content']['payload']['channel_name'],
                storyType: message.data['content']['payload']['story_type'],
                siteUrl: message.data['content']['payload']['href'])));
    */
  /*_navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (ctx) =>
            DetailsScreen(
                userName: message.data['content']['payload']['channel_name'],
                storyType: message.data['content']['payload']['story_type'],
                siteUrl: message.data['content']['payload']['href'])));*/ /*
  } else */ /*if (message.data['content']['payload']['type'] == 'system')*/ /* {
    Navigator.push(
        _navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  tabIndex: 3,
                )));
  }*/
  /*AwesomeNotifications().actionStream.listen((event) {
    log(message.data.toString());
    log(message.data['content']['payload']['type'].toString());
    */ /* else {}*/ /*
  });*/
}

bool _sendNotif = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  var _prefs = await SharedPreferences.getInstance();
  _sendNotif = _prefs.getBool(SavedKeys().notificationValue) ?? true;
  await SharedPrefs().init();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
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
      // !
      //         .requestPermission()
      : await flutterPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
  runApp(const MyApp());
}

void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  //fn(message)
}
void selectNotification(var payload) async {}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (_sendNotif) {
    fn(message);
  }
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
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      if (_sendNotif) {
        fn(initialMessage);
      }
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    //FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (event) async {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        if (notification != null && android != null && _sendNotif) {
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
        if (_sendNotif) {
          fn(event);
        }
        //log(event.data['content']['payload']['type'].toString());
        /*if (event.data['content']['payload']['type'] == 'story') {
          _navigatorKey.currentState?.push(MaterialPageRoute(
              builder: (ctx) => DetailsScreen(
                  userName: event.data['content']['payload']['channel_name'],
                  storyType: event.data['content']['payload']['story_type'],
                  siteUrl: event.data['content']['payload']['href'])));
        } else if (event.data['content']['payload']['type'] == 'system') {
          _navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => TabsScreen(
                tabIndex: 3,
              ),
            ),
          );
        } else {
          log('else');
        }*/
        //log('onmessage' + event.data.toString());
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) async {
        /* AwesomeNotifications().createNotificationFromJsonData(event.data);
        AwesomeNotifications().actionStream.listen((event1) {
          fn(event);
        });*/
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;
        if (notification != null && android != null && _sendNotif) {
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
        if (_sendNotif) {
          fn(event);
        }
        /*if (event.data['content']['payload']['type'] == 'story') {
        _navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (ctx) => DetailsScreen(
                userName: event.data['content']['payload']['channel_name'],
                storyType: event.data['content']['payload']['story_type'],
                siteUrl: event.data['content']['payload']['href'])));
      } else if (event.data['content']['payload']['type'] == 'system') {
        _navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => TabsScreen(
              tabIndex: 3,
            ),
          ),
        );
      } else {
        log('else');
      }*/
        //log('onMessageOpened' + event.data.toString());
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
            // home: IntroFinal(
            //   onBackTap: () {},
            // ),

            // home: IntroFinal(onBackTap: () {},),
            // home:ProductAdded(name: '', price: '', productImage: '',)
            );
        //Dashboard());
      },
    );
  }
}
