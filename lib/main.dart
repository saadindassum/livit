import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:livit/providers/user_provider.dart';
import 'package:livit/responsive/mobile_layout.dart';
import 'package:livit/responsive/resp_layout.dart';
import 'package:livit/responsive/web_layout.dart';
import 'package:livit/screens/login_screen.dart';
import 'package:livit/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize Web or App for firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB-rH-DC3gitOeOloJ82yJ34zm0Ll2LiJs',
        appId: '1:335623137735:web:1c3087e0f4d963f94011e2',
        messagingSenderId: '335623137735',
        projectId: 'livit-dassumluo',
        storageBucket: 'livit-dassumluo.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // this widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LivIt',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // check if snapshot has data
            if (snapshot.connectionState == ConnectionState.active) {
              // if snapshot has data, user is logged in,
              // check screen width and display correct screen layout
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
