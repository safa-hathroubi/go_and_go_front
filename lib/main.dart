import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_and_go/screen/Addtrajet.dart';
import 'package:go_and_go/screen/groupe.dart';
import 'package:go_and_go/screen/home.dart';
import 'package:go_and_go/screen/login.dart';
import 'package:go_and_go/screen/parametres.dart';
import 'package:go_and_go/screen/savelife.dart';
import 'package:go_and_go/screen/splash_screen.dart';
import 'package:go_and_go/screen/startScreen.dart';
import 'package:provider/provider.dart';

import 'controllers/Cars_provider.dart';
import 'controllers/chat_provider.dart';
import 'controllers/login_provider.dart';
import 'screen/Chat/chat_list_screen.dart';
import 'screen/Chat/static_chat/main_chat_page.dart';

Widget defaultHome = const splashScreen();

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  //final entrypoint = prefs.getBool('entrypoint') ?? false;
  // final loggedIn = prefs.getBool('loggedIn') ?? false;
  //    if (entrypoint && !loggedIn) {
  //  defaultHome = const loginScreen();
  // } else if (entrypoint && loggedIn) {
  // defaultHome = const home();
  //}
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => CarNotifier()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inetum Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: defaultHome,
      routes: {
        '/home': (context) => home(),
        '/addtrajet': (context) => addtrajet(),
        '/groupe': (context) => groupe(),
        '/parametres': (context) => parametres(),
        '/savelive': (context) => savelife(),
        //'/chat1': (context) => Chat1(),
        '/chatList': (context) => ChatListScreen(),
        '/login': (context) => loginScreen(),
        '/start': (context) => startScreen(),
        '/staticChat': (context) => ChatChat(),
      },
    );
  }
}
