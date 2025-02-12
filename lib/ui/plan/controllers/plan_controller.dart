import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/database/helper/db_helper.dart';
import 'package:women_lose_weight_flutter/database/table/history_table.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';
import '../../../database/table/home_plan_table.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';

class PlanController extends GetxController {
  List<HomePlanTable> bodyFocusList = [];
  int currentPlanIndex = 0;

  List? dayProgressData;
  String txtDayLeft = "0";
  double pbDay = 0.0;
  String btnDays = " 0";

  List<HistoryTable> recentHistoryList = [];
  List<HomePlanTable> homePlanTableList = [];

  @override
  void onInit() {
    _fillMainGoalData();
    _getBodyFocusData();
    getRecentHistoryData();
    super.onInit();
  }

  _fillMainGoalData() async {
    currentPlanIndex =
        Preference.shared.getInt(Preference.selectedPlanIndex) ?? 0;

    dayProgressData = await Utils.setDayProgressData();

    if (dayProgressData != []) {
      txtDayLeft = dayProgressData![1];
      pbDay = dayProgressData![3];
      btnDays = dayProgressData![4];
    }
    update([Constant.idYourPlanProgressDetails]);
  }

  _getBodyFocusData() async {
    bodyFocusList =
    await DBHelper.dbHelper.getHomePlanList(Constant.planTypeBodyFocus);
    update([Constant.idBodyFocusList]);
  }

  onBodyFocusItemClick(HomePlanTable bodyFocusItem) {
    Get.toNamed(AppRoutes.homeDetail, arguments: [bodyFocusItem])!.then((value) => refreshData());
  }

  getRecentHistoryData() async {
    recentHistoryList.clear();
    recentHistoryList = await DBHelper.dbHelper.getRecentHistoryData();
    update([Constant.idPlanRecentHistory]);
  }

  refreshData() {
    _fillMainGoalData();
    getRecentHistoryData();
    // Removed the call to _reportController.refreshData();
  }

  HomePlanTable? homePlanTable;
  onRecentItemClick() async {
    homePlanTable = await DBHelper.dbHelper
        .getPlanByPlanId(int.parse(recentHistoryList[0].hPlanId.toString()));

    if (recentHistoryList[0].planDetail!.hasSubPlan!) {
      Get.toNamed(AppRoutes.fastWorkOutDetail)!.then((value) => refreshData());
    } else if (recentHistoryList[0].planDetail!.planDays == Constant.planDaysYes) {
      Get.toNamed(AppRoutes.daysPlanDetail)!.then((value) => refreshData());
    } else {
      Get.toNamed(AppRoutes.exerciseList, arguments: [homePlanTable, null, null])!.then((value) => refreshData());
    }
  }

  getRecentItemTime() async {
    int compDay = await DBHelper.dbHelper.getCompleteDayCountByPlanId(
        recentHistoryList[0].planDetail!.planId!.toString());
    if (recentHistoryList[0].planDetail!.planDays == Constant.planDaysYes) {
      return "${recentHistoryList[0].planDetail!.days! - compDay} ${"txtDaysLeft".tr}";
    } else {
      return "${recentHistoryList[0].planDetail!.planMinutes!} ${"txtMins".tr}";
    }
  }
}