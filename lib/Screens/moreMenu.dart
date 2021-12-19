import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanglis_bible_mobileapp/Screens/bookmarkListing.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreMenu extends StatefulWidget {
  const MoreMenu({Key? key}) : super(key: key);

  @override
  _MoreMenuState createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
  @override
  Widget build(BuildContext context) {
    var _time = Time(20, 35, 0);



    FlutterLocalNotificationsPlugin localNotification;

    localNotification = new FlutterLocalNotificationsPlugin();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
    @override
    void initState() {
      super.initState();


    }
    Future _showNotificatio() async {
      var androidDetails = new AndroidNotificationDetails(
        "channelId",
        "Reminder Notification",
        "This is a reminder notification",
        icon: "ic_launcher",
        importance: Importance.high,
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher")
      );
      var iosDetails = new IOSNotificationDetails();
      var generalNotificationDetails = new NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );
      try {
        await localNotification.showDailyAtTime(
            0, 'Reminder', 'Its Time to read your bible. Tap to open now', _time, generalNotificationDetails);
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),

        );
      }
    }
    Future<dynamic> _selectTime() async {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState(() {
        var hour = newTime?.hour.toInt();
        var min = newTime?.minute.toInt();
        _time = Time(hour!, min!, 0);
      });
      _showNotificatio();
      Fluttertoast.showToast(msg: 'Reminder set successfully');
    }
    bool status = true;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                _selectTime();
              },
              leading: Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
              title: Text(
                'Set Reminder',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BookMarkListing()));
              },
              leading: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              title: Text(
                'Bookmarks',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              onTap: () {
                _launchURL('http://tanglishbible.com/privacy-policy/');
              },
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.white,
              ),
              title: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              onTap: () {
                FlutterShare.share(
                  title: 'Download Tanglish Bible Mobile App',
                  text:
                  'Download Tanglish Bible Mobile application from ap store. Which will really help you to read Tamil bible in english. Download Today!!!',
                  linkUrl:
                  'http://tanglishbible.com/#/',
                  //chooserTitle: 'Example Chooser Title'
                );

              },
              leading: Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text(
                'Share App',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              onTap: () {
                _launchURL('http://tanglishbible.com/');
              },
              leading: Icon(
                Icons.language,
                color: Colors.white,
              ),
              title: Text(
                'Website',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'GS APP Studio',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  void _launchURL(String _url) async {
    try {
      launch(_url);
    } catch (e) {
      print(e.toString());
    }
  }
}
