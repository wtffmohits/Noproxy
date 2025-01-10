import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noproxy/components/controller/Db/Db_helper.dart';
import 'package:noproxy/firebase_options.dart';
import 'package:noproxy/main.dart';
import 'package:noproxy/screens/onbording/onbording_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      themeMode: ThemeMode.system,
      // theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      title: 'Test App',
      home: OnBordingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
