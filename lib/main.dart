import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/view/addTrainingSession/pages/addTrainingSession.dart';
import 'package:interval_timer_app/view/authentication/login/login.dart';
import 'package:interval_timer_app/view/authentication/register/register.dart';
import 'package:interval_timer_app/view/homepage/pages/homepage.dart';
import 'package:interval_timer_app/view/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new TrainingSessionsProvider(),
      child: MaterialApp(
        title: 'Demo app',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Interval timer app'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
