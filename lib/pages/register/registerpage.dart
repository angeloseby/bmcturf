import 'package:bmcturf/pages/login/loginpage.dart';
import 'package:bmcturf/pages/otp/otppage.dart';
import 'package:bmcturf/services/auth_provider.dart';
import 'package:bmcturf/utils/color_scheme.dart';
import 'package:bmcturf/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Define controllers for each input field
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // Define a global form key to validate the form
  final _formKey = GlobalKey<FormState>();

  // Password view / hide variable
  bool hidden = true;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Create a new\nacccount",
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
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          maxLength: 10,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            counterStyle: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                            labelText: 'Phone Number',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: validatePhoneNumber,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidden = showHidePassword(hidden);
                                });
                              },
                              child: Icon(
                                hidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          obscureText: hidden,
                          validator: validatePassword,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            if (_submitForm()) {
                              authProvider.onOtpSent = (phone) {
                                // Handle when OTP is sent
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (builder) {
                                      return const OTPPage();
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('OTP sent to $phone')),
                                );
                              };

                              authProvider.onAuthError = (errorMessage) {
                                // Handle authentication errors
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Error: $errorMessage')),
                                );
                              };

                              authProvider
                                  .sendOtp(_phoneController.text.trim());
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                          ),
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "Register",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Already have an account ? Login.",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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

  // Function to handle form submission
  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a success message
      return true;
    } else {
      // If the form is not valid, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form'),
        ),
      );
      return false;
    }
  }
}
