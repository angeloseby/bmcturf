import 'package:bmcturf/services/auth_provider.dart';
import 'package:bmcturf/utils/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  //Controller for controlling the otp fields
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: CustomColorScheme.kSplashScreenScaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Verification Code",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "We have sent the verification code \nto your phone number",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Text(
                        "+91 9567778213",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Edit?",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(
                        flex: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Enter the code",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //OTP Boxes
                PinCodeTextField(
                  appContext: context,
                  length: 6, // Number of OTP digits
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.grey[300],
                    selectedFillColor: Colors.blue[100],
                    inactiveColor: Colors.white,
                    selectedColor:
                        CustomColorScheme.kSplashScreenScaffoldGradientColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  // onChanged: (value) {
                  //   print('OTP value: $value');
                  // },
                  onCompleted: (value) {
                    print('Completed OTP: $value');
                    authProvider.verifyOtp(_otpController.text, context);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () {
                    authProvider.verifyOtp(_otpController.text, context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          "Verify",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
