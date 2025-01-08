import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/plan/controllers/plan_controller.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../home/controllers/home_controller.dart';

class PlanScreen extends StatelessWidget {
  PlanScreen({super.key});

  final PlanController _planController = Get.find<PlanController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.height_3,
        horizontal: AppSizes.width_5,
      ),
      child: Column(
        children: [
          _widgetSelectedPlan(),
          _textDaily(),
          _widgetWaterTracker(),
        ],
      ),
    );
  }


  _widgetSelectedPlan() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.daysPlanDetail)!
            .then((value) => _planController.refreshData());
      },
      child: SizedBox(
        height: AppSizes.height_42,
        width: AppSizes.fullWidth,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GetBuilder<PlanController>(
              id: Constant.idYourPlanProgressDetails,
              builder: (logic) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        offset: Offset(0.0, 2.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Utils.getSelectedPlanImage(
                          _planController.currentPlanIndex),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            Container(
              width: AppSizes.fullWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.width_6, vertical: AppSizes.height_2_5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  GetBuilder<PlanController>(
                    builder: (logic) {
                      return AutoSizeText(
                        Utils.getSelectedPlanName(
                            _planController.currentPlanIndex),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColor.txtColor333,
                          fontSize: AppFontSize.size_15,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  GetBuilder<PlanController>(
                    id: Constant.idYourPlanProgressDetails,
                    builder: (logic) {
                      return Text(
                        "${logic.txtDayLeft}\t${"Days Left"}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.txtColor333,
                          fontSize: AppFontSize.size_12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  GetBuilder<PlanController>(
                    builder: (logic) {
                      return Container(
                        width: AppSizes.fullWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColor.greenGradualStartColor,
                              AppColor.greenGradualEndColor,
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.daysPlanDetail)!
                                .then((value) => _planController.refreshData());
                          },
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
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
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizes.height_1),
                            child: Text(
                              logic.btnDays == "Finished"
                                  ? "Finished"
                                  : "Day".toUpperCase() + logic.btnDays,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: AppFontSize.size_15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textDaily() {
    return Container(
      margin:
          EdgeInsets.only(top: AppSizes.height_3, bottom: AppSizes.height_1_5),
      width: AppSizes.fullWidth,
      child: AutoSizeText(
        "Daily",
        textAlign: TextAlign.left,
        maxLines: 1,
        style: TextStyle(
          color: AppColor.black,
          fontSize: AppFontSize.size_14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _widgetWaterTracker() {
    return GetBuilder<HomeController>(
        id: Constant.idCurrentWaterGlass,
        builder: (logic) {
          return Card(
            margin: const EdgeInsets.all(0.0),
            elevation: 2.0, //shadow effect
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              width: AppSizes.fullWidth,
              decoration: BoxDecoration(
                color: AppColor.cardBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.height_3, horizontal: AppSizes.width_5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Water Tracker",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.size_14,
                            color: AppColor.black,
                          ),
                        ),
                        if (Utils.isWaterTrackerOn()) ...{
                          Container(
                            margin: EdgeInsets.only(
                                top: AppSizes.height_1_3,
                                bottom: AppSizes.height_2_5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  logic.currentGlass.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.size_21,
                                    color: AppColor.commonBlueColor,
                                  ),
                                ),
                                Text(
                                  "\t${"/8 Cups"}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.size_14,
                                    color: AppColor.txtColor666,
                                  ),
                                ),
                              ],
                            ),
                          )
                        },
                        SizedBox(
                          width: AppSizes.fullWidth,
                          child: TextButton(
                            onPressed: () {
                              if (Utils.isWaterTrackerOn()) {
                                Get.toNamed(AppRoutes.waterTracker,
                                    arguments: [logic.currentGlass]);
                                logic.currentWaterGlass();
                              } else {
                                Get.toNamed(AppRoutes.turnOnWater,
                                    arguments: [logic.currentGlass]);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  AppColor.commonBlueColor),
                              elevation: WidgetStateProperty.all(2),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: const BorderSide(
                                      color: AppColor.transparent, width: 0.7),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.height_0_6),
                              child: Text(
                                "Drink".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: AppFontSize.size_14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSizes.height_13,
                    width: AppSizes.height_13,
                    margin: EdgeInsets.only(left: AppSizes.width_7),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: AppColor.commonBlueLightColor,
                          value: logic.currentGlass! / 8,
                          valueColor: const AlwaysStoppedAnimation(
                              AppColor.commonBlueColor),
                          strokeWidth: AppSizes.width_1_7,
                        ),
                        Padding(
                          padding: EdgeInsets.all(AppSizes.width_7_2),
                          child: Image.asset(
                            Constant.getAssetIcons() + "ic_homepage_drink.webp",
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
