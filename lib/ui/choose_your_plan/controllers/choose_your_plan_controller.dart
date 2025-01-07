import 'package:get/get.dart'; //state management + navigation
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

class ChooseYourPlanController extends GetxController {
  List<ChooseYourPlanData> chooseYourPlanList = [];
  int selectedChoosePlanIndex = 0;

  @override
  void onInit() {
    _choosePlanListData();
    _getAllPreference();
    super.onInit();
  }

  _choosePlanListData() {
    chooseYourPlanList = [
      ChooseYourPlanData(
          planName: "Lose Weight & Keep Fit",
          planImage: "ic_goal_lose_weight_keep.webp"),

    ];
  }

  void onChooseYourPlanClick(int index) {
    selectedChoosePlanIndex = index;
    Preference.shared
        .setInt(Preference.selectedPlanIndex, selectedChoosePlanIndex);
    Preference.shared
        .setInt(Preference.selectedPlanId, (selectedChoosePlanIndex + 1));
    update([Constant.idChooseYourPlanList]);
  }

  _getAllPreference() {
    selectedChoosePlanIndex =
        Preference.shared.getInt(Preference.selectedPlanIndex) ?? 0;
  }
}

class ChooseYourPlanData {
  String? planName;
  String? planImage;

  ChooseYourPlanData({this.planName, this.planImage});
}