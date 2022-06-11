import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepanel/screens/game_screen.dart';
import 'package:gamepanel/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gamepanel',
      theme: ThemeData(
        textTheme: GoogleFonts.bangersTextTheme(),
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          background: Color(0xffEDEDED),
          primary: Color(0xff505050),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/game', page: () => const GameScreen(), parameters: const {'level': '0'}),
      ],
      initialRoute: '/',
    );
  }
}
