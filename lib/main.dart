import 'package:flutter/material.dart';
import 'package:tanglis_bible_mobileapp/Screens/navBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'id',
  'name',
  'description',
importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundhandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('Message: ${message.messageId}');

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundhandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
RemoteNotification? notification = message.notification;
AndroidNotification? androidNotification = message.notification?.android;
flutterLocalNotificationsPlugin.show(
  notification.hashCode,
  notification?.title,
  notification?.body,
  NotificationDetails(
    android: AndroidNotificationDetails(
      channel.id,
      channel.name,
      channel.description,
      playSound: true,
      color: Colors.transparent,
      icon: 'ic_launcher',
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher")
    )
  )
);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home:
        NavBar()
    );
  }
}
