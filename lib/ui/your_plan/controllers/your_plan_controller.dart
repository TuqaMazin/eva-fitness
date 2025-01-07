import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../routes/app_routes.dart';

class YourPlanController extends GetxController {
  int? selectedPlanIndex;

  String txtDayLeft = "0";
  double pbDay = 0.0;

  List? dayProgressData;

  @override
  void onInit() {
    _getPreferenceData();
    super.onInit();
  }

  _getPreferenceData() {
    selectedPlanIndex =
        Preference.shared.getInt(Preference.selectedPlanIndex) ?? 0;
  }



  onGoButtonAndGoToSignPageClick() {
    Preference.shared.setBool(Preference.isFirstTimeOpenApp, Constant.boolValueFalse);
    Get.offAllNamed(AppRoutes.signIn);
  }
}