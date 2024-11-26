import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  bool _isLoading = false;
  String? _errorMessage; // Holds the last error message
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  // Callback for success and error
  Function(String)? onOtpSent;
  Function(String)? onAuthError;

  AuthProvider() {
    _checkAuthState();
  }

  //function to check whether user is null or not ie, authenticated or not
  void _checkAuthState() {
    if (kDebugMode) {
      print("check auth state called");
    }
    _auth.authStateChanges().listen((User? user) {
      _isAuthenticated = user != null;
      if (kDebugMode) {
        print("isAuthenticated : $_isAuthenticated");
      }
      notifyListeners();
      if (kDebugMode) {
        print("notify listeners");
      }
    });
  }

  //function to check whether user is null or not ie, authenticated or not
  Future<void> signOut() async {
    await _auth.signOut();
    _isAuthenticated = false;
    notifyListeners();
  }

  // Function to send OTP
  Future<void> sendOtp(String phoneNumber) async {
    _setLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user
          if (kDebugMode) {
            print("verification completed");
          }
          await _auth.signInWithCredential(credential);
          _setLoading(false);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print("verification failed");
          }
          _setLoading(false);
          _handleError(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          if (kDebugMode) {
            print("code sent");
          }
          _verificationId = verificationId;
          _setLoading(false);
          if (onOtpSent != null) {
            onOtpSent!("+91 $phoneNumber");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print("code retrieval timeout");
          }
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("error catched");
      }
      _setLoading(false);
      _handleError(e.toString());
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp(String otp, BuildContext context) async {
    _setLoading(true);
    try {
      if (_verificationId == null) {
        throw Exception("Verification ID is null");
      }
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      _setLoading(false);
      _checkAuthState();
      Navigator.of(context).pop();
    } catch (e) {
      _setLoading(false);
      _handleError(e.toString());
    }
  }

  // Private helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleError(String message) {
    _errorMessage = message;
    notifyListeners();
    if (onAuthError != null) {
      onAuthError!(message);
    }
  }
}
