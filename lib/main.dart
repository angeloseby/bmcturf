import 'package:bmcturf/firebase_options.dart';
import 'package:bmcturf/pages/login/loginpage.dart';
import 'package:bmcturf/pages/otp/otppage.dart';
import 'package:bmcturf/utils/color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMC Turf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: CustomColorScheme.kPrimary),
        useMaterial3: true,
      ),
      home: const OTPPage(),
    );
  }
}
