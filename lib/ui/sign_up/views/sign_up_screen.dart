import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constant.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgGrayScreen,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            _txtSignUpWidget(),
            _signUpDetailsWidget(),
          ],
        ),
      ),
    );
  }

  _txtSignUpWidget() {
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
            "Sign Up".tr.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.size_15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSizes.height_0_4),
          Text(
            "Sign up to discover amazing thing near\naround you",
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

  _signUpDetailsWidget() {
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
          _fullNameTextField(),
          SizedBox(height: AppSizes.height_2),
          _emailTextField(),
          SizedBox(height: AppSizes.height_2),
          _passwordTextField(),
          SizedBox(height: AppSizes.height_3),
          _signUpButton(),
          SizedBox(height: AppSizes.height_3_5),
          _txtPrivacyPolicy(),
          SizedBox(height: AppSizes.height_3_5),
          _txtAlreadyAccountSignIn(),
        ],
      ),
    );
  }

  _fullNameTextField() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: TextFormField(
        controller: fullName,
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
          hintText: "Full Name",
          hintStyle: TextStyle(
            color: AppColor.txtColor999,
            fontSize: AppFontSize.size_12,
            fontWeight: FontWeight.w500,
          ),
          filled: Constant.boolValueTrue,
          fillColor: AppColor.bgGaryTextFormField,
          counterText: "",
          prefixIcon: const Icon(
            Icons.person,
            color: AppColor.txtColor999,
          ),
          border: InputBorder.none,
        ),
        onEditingComplete: () {
          FocusScope.of(Get.context!).unfocus();
        },
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
        onEditingComplete: () {
          FocusScope.of(Get.context!).unfocus();
        },
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
        obscureText: true, // This line makes the password hidden
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
          FocusScope.of(Get.context!).unfocus();
        },
      ),
    );
  }

  _signUpButton() {
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
          Get.toNamed(AppRoutes.signIn);
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
        child: GestureDetector(
          onTap: () async {
            signUpWithEmailAndPassword(
              email.text,
              password.text,
              fullName.text,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizes.height_1),
            child: Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.size_13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _txtPrivacyPolicy() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By signing up you accepted for',
        style: TextStyle(
          color: AppColor.txtColor999,
          fontSize: AppFontSize.size_9,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Terms of Services',
            style: const TextStyle(
              color: AppColor.txtColorGreen,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(text: 'and'),
          TextSpan(
            text: 'Privacy policy',
            style: const TextStyle(
              color: AppColor.txtColorGreen,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }

  _txtAlreadyAccountSignIn() {
    return Container(
      margin: EdgeInsets.only(
          top: AppSizes.height_3_5, bottom: AppSizes.height_2_5),
      child: RichText(
        text: TextSpan(
          text: "${'Already account'}? ",
          style: TextStyle(
            color: AppColor.txtColor999,
            fontSize: AppFontSize.size_12_5,
            fontWeight: FontWeight.w700,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                color: AppColor.txtColorGreen,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.back();
                },
            ),
          ],
        ),
      ),
    );
  }
}

Future<User?> signUpWithEmailAndPassword(
    String email, String password, String fullName) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // Update user profile with the full name
      await user.updateDisplayName(fullName);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      // Store the user's full name and other details in Firestore
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        'userId': user.uid,
        'userName': fullName,
        'userEmail': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("User signed up and data stored successfully: ${user.uid}");
    }

    return user;
  } catch (e) {
    print("Error signing up: $e");
    return null;
  }
}
