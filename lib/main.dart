import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interval_timer_app/providers/trainingSessionsProvider.dart';
import 'package:interval_timer_app/view/splash/splash.dart';
import 'package:provider/provider.dart';

///Entry point of the application. There's not much stuff here except we force device orientation to portrait mode only and then proceed to Splash screen.
///Also the Material App (root widget of our app) is wrapped with ChangeNotifiedProvider, a widget that basically provides specified class (TrainingSessionProvider) to all of it's child widgets. Those child widgets will be able to use
///the methods and data of the provided class. This is way of state management that is superior in terms of efficiency and ease of use in majority of situations where we have data that needs to be displayed depending on other factors.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
