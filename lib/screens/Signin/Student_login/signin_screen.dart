import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noproxy/screens/Signin/Student_login/otp_screen.dart';
import 'package:noproxy/widgets/Themes/buttons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _verificationId;

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");
  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String phoneNumber =
        '+${selectedCountry.phoneCode}${phoneController.text.trim()}';

    try {
      if (kIsWeb) {
        ConfirmationResult confirmationResult =
            await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
        _verificationId = confirmationResult.verificationId;
        setState(() {
          _isLoading = false;
          //navigate to OTP screen
          _navigateToOtpScreen();
        });
      } else {
        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {
              // auto sign in in case of auto verification
              _signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'Verification Failed: ${e.message}';
              });
            },
            codeSent: (String verificationId, int? resendToken) {
              setState(() {
                _isLoading = false;
                _verificationId = verificationId;
                _navigateToOtpScreen();
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              setState(() {
                _isLoading = false;
              });
            });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error sending code: ${e.message}';
      });
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // navigate to next screen
        print("signed in successfully");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Error signing in: ${e.message}';
        _isLoading = false;
      });
    }
  }

  void _navigateToOtpScreen() {
    if (_verificationId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            verificationId: _verificationId!,
            phoneNumber:
                '+${selectedCountry.phoneCode}${phoneController.text.trim()}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade50,
                    ),
                    child: Image.asset("assets/images/loggg-rem.png"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Enter your Phone number. We'll send you verification code",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: "Enter the Number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: const Icon(
                                Icons.done_sharp,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: "Login",
                            onPressed: _sendVerificationCode,
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
