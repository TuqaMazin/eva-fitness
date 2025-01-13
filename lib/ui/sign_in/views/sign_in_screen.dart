import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AppSizes appSizes;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    appSizes = AppSizes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgGrayScreen,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _txtSignInWidget(),
            _signInDetailsWidget(),
          ],
        ),
      ),
    );
  }

  _txtSignInWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      width: AppSizes.fullWidth,
      height: AppSizes.fullHeight / 2,
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
          left: AppSizes.width_5,
          right: AppSizes.width_5,
          top: AppSizes.height_6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSizes.height_10),
          Text(
            "Sign In".toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.size_15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSizes.height_0_4),
          Text(
            "Sign in to discover amazing thing near\naround you",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.size_10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  _signInDetailsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: kElevationToShadow[4],
      ),
      margin: EdgeInsets.only(
          left: AppSizes.width_5,
          right: AppSizes.width_5,
          top: AppSizes.fullHeight / 3.5,
          bottom: AppSizes.height_3),
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.height_3, horizontal: AppSizes.width_5),
      child: Column(
        children: [
          _emailTextField(),
          SizedBox(height: AppSizes.height_2),
          _passwordTextField(),
          SizedBox(height: AppSizes.height_3),
          _signInButton(),
          SizedBox(height: AppSizes.height_5),
          _txtForgotPassword(),
          _txtCreateAccount(),
        ],
      ),
    );
  }

  _emailTextField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: TextFormField(
        controller: email,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: AppColor.black,
          fontSize: AppFontSize.size_12,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
            color: AppColor.txtColor999,
            fontSize: AppFontSize.size_12,
            fontWeight: FontWeight.w500,
          ),
          filled: Constant.boolValueTrue,
          fillColor: AppColor.bgGaryTextFormField,
          counterText: "",
          prefixIcon: const Icon(
            Icons.email,
            color: AppColor.txtColor999,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _passwordTextField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: TextFormField(
        controller: password,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: AppColor.black,
          fontSize: AppFontSize.size_12,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColor.primary,
        obscureText: true, // Make the password hidden
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: AppColor.txtColor999,
            fontSize: AppFontSize.size_12,
            fontWeight: FontWeight.w500,
          ),
          filled: Constant.boolValueTrue,
          fillColor: AppColor.bgGaryTextFormField,
          counterText: "",
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: AppColor.txtColor999,
          ),
          border: InputBorder.none,
        ),
        onEditingComplete: () {
          FocusScope.of(Get.context!).unfocus(); //hide
        },
      ),
    );
  }

  _signInButton() {
    return Container(
      width: AppSizes.fullWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          begin: Alignment.center,
          end: Alignment.center,
          colors: [
            AppColor.primary,
            AppColor.primary,
          ],
        ),
      ),
      child: TextButton(
        onPressed: () {
          signInWithEmailAndPassword(
            email.text,
            password.text,
            context,
          );
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(
                color: AppColor.transparent,
                width: 0.7,
              ),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.height_1),
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.size_13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  _txtForgotPassword() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.verifyYourAccount);
      },
      child: Text(
        "Forgot Password?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColor.txtColorGreen,
          fontSize: AppFontSize.size_13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _txtCreateAccount() {
    return Container(
      margin:
          EdgeInsets.only(top: AppSizes.height_5, bottom: AppSizes.height_3_5),
      child: RichText(
        text: TextSpan(
          text: "${'Create Account'}? ",
          style: TextStyle(
            color: AppColor.txtColor999,
            fontSize: AppFontSize.size_12_5,
            fontWeight: FontWeight.w700,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
              style: const TextStyle(
                color: AppColor.txtColorGreen,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.signUp);
                },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signInWithEmailAndPassword(
  String email,
  String password,
  BuildContext context,
) async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // Hide the loading indicator
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User signed in successfully."),
        ),
      );

      // Redirect to the home page
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
      );
    }
  } on FirebaseAuthException catch (e) {
    // Hide the loading indicator
    Navigator.of(context).pop();

    String errorMessage = '';
    switch (e.code) {
      case 'user-not-found':
        errorMessage = "No user found for that email.";
        break;
      case 'wrong-password':
        errorMessage = "Wrong password provided for that user.";
        break;
      case 'invalid-email':
        errorMessage = "The email address is not valid.";
        break;
      default:
        errorMessage = "An error occurred: ${e.message}";
    }

    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    // Hide the loading indicator
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An unexpected error occurred: $e")),
    );
  }
}
