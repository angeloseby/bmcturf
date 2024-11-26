import 'package:bmcturf/services/auth_provider.dart';
import 'package:bmcturf/utils/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: CustomColorScheme.kSplashScreenScaffoldColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  CustomColorScheme.kSplashScreenScaffoldGradientColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * 0.35,
                child: Image.asset("assets/images/bmclogo.png"),
              ),
              Text(
                "BMC TURF",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              TextButton(
                  onPressed: () {
                    authProvider.signOut();
                  },
                  child: const Text("Sign Out"))
            ],
          ),
        ],
      ),
    );
  }
}
