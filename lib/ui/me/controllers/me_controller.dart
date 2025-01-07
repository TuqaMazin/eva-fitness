import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_lose_weight_flutter/database/helper/firestore_helper.dart';
import 'package:women_lose_weight_flutter/localization/localizations_delegate.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/home/controllers/home_controller.dart';
import 'package:women_lose_weight_flutter/ui/me/views/me_screen.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/debug.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../database/helper/db_helper.dart';
import '../../../utils/utils.dart';
import '../../plan/controllers/plan_controller.dart';

class MeController extends GetxController {
  bool isTurnOnWaterTracker = Constant.boolValueFalse;
  String? lastSyncDate;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  final HomeController _homeController = Get.find<HomeController>();
  final PlanController _planController = Get.find<PlanController>();

  @override
  void onInit() {
    _initialGetPreferenceData();
    getLastSyncDate();
    super.onInit();
  }



  onTurnOnWaterTrackerToggleSwitchChange(bool value) {
    isTurnOnWaterTracker = value;

    if (isTurnOnWaterTracker) {
      Utils.setWaterReminderNotifications();
    } else {
      Utils.cancelWaterReminderNotifications();
    }

    Preference.shared
        .setBool(Preference.turnOnWaterTracker, isTurnOnWaterTracker);

    update([Constant.idMeTurnOnWaterTrackerSwitch]);
  }

  _initialGetPreferenceData() {
    isTurnOnWaterTracker =
        Preference.shared.getBool(Preference.turnOnWaterTracker) ??
            Constant.boolValueTrue;



    _homeController.isPurchase();
  }





  Future<void> loadPrivacyPolicy() async {
    var url = Uri.parse(Constant.getPrivacyPolicyURL());
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw "Cannot load the page";
    }
  }





  getLastSyncDate() {
    lastSyncDate = Preference.shared.getString(Preference.lastSyncDate) ?? "";
    update([Constant.idLoginInfo]);
  }

  Future<void> signOutFromGoogle() async {
    await Preference.shared.firebaseLogout();
    await firebaseAuth.signOut();
    Utils.showToast(Get.context!, "txtLogoutSuccess".tr);
    update([Constant.idLoginInfo]);
  }

  onSignInButtonClick() async {
    if (await Utils.isInternetConnectivity()) {
      if (Utils.getFirebaseUid() == null) {
        _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
      } else {
        MeScreen().showLogoutDialog();
      }
    } else {
      Utils.showToast(Get.context!, "txtInternetConnection".tr);
    }
  }

  onSyncButtonClick() async {
    if (await Utils.isInternetConnectivity()) {
      _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
      if (Utils.getFirebaseUid() == null) {
      } else {
        FirestoreHelper().onSyncButtonClick();
      }
    } else {
      Utils.showToast(Get.context!, "txtInternetConnection".tr);
    }
  }

  onPremiumBtnClick() {
    Get.toNamed(AppRoutes.accessAllFeature)!.then((value) {
      if (value != null && value == true) {
        _homeController.isShowPremiumBtn = false;
        update([Constant.idMeGoPremiumBtn]);
      }
    });
  }

  Future<void> deleteAccountFromGoogle() async {
    _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
    FirestoreHelper().deleteUserAccountPermanently().then((value) async {
      await Preference.shared.firebaseLogout();
      if (firebaseAuth.currentUser != null) firebaseAuth.currentUser!.delete();
      await firebaseAuth.signOut();
      await DBHelper.dbHelper
          .restartProgress()
          .then((value) => _planController.refreshData());
      _homeController.onChangeIsShowLoading(Constant.boolValueFalse);
      Utils.showToast(Get.context!, "txtDeleteAccountSuccessfully".tr);
      update([Constant.idLoginInfo]);
    });
  }
}
