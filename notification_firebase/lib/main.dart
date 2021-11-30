import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_firebase/screens/welcome.dart';

final firestore = FirebaseFirestore.instance;

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Welcome.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(title: "Home page"),
        Welcome.id: (context) => Welcome(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id = "/home";
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin localNotification;

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Daxili Bildirish",
      "This is the description of the Notification, you can write anything",
    );
    var iOSDesails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iOSDesails,
    );
    await localNotification.cancel(7);
    setState(() {});
  }

  Future _sendNotification(String user, String text) async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Daxili Bildirish",
      "This is the description of the Notification, you can write anything",
    );
    var iOSDesails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iOSDesails,
    );
    await localNotification.show(7, user, text, generalNotificationDetails);
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    var androidInitialize =
        new AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOSIntialize = new IOSInitializationSettings();
    var initialzationSettings = new InitializationSettings(
      android: androidInitialize,
      iOS: iOSIntialize,
    );
    localNotification = new FlutterLocalNotificationsPlugin();

    localNotification.initialize(
      initialzationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection("messages").snapshots(),
              builder: (context, snapshot) {
                for (var mesaj in snapshot.data!.docChanges) {
                  String text = mesaj.doc.get('text');
                  String sender = mesaj.doc.get('sender');
                  _sendNotification(sender, text);
                }
                print("begin stream builder");
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  String data = "";
                  for (var message in messages) {
                    data = message.get("text");
                    final messageSender = message.get("sender");
                  }
                  return Text(data);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendNotification("A", "B");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
