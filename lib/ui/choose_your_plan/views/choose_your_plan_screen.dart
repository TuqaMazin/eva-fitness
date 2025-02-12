import 'package:flutter/material.dart'; //UI for application
import 'package:get/get.dart'; //state management + navigation
import 'package:women_lose_weight_flutter/routes/app_routes.dart'; //for navigation
import 'package:women_lose_weight_flutter/ui/choose_your_plan/controllers/choose_your_plan_controller.dart'; //managing the state
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart'; //variables with initials value
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart'; //import size
class ChooseYourPlanScreen extends StatelessWidget {
  ChooseYourPlanScreen({super.key});

  final ChooseYourPlanController _chooseYourPlanController =
  Get.find<ChooseYourPlanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold( //basic design
      backgroundColor: AppColor.white,
      body: SafeArea( //ensure the ui does not hava overflow
        child: Column(
          children: [
            _textChooseYouPlan(),
            _textLoseWeightWithThePlan(),
            const SizedBox(height: 250.0),
            _choosePlanList(),
          ],
        ),
      ),
    );
  }


  _textChooseYouPlan() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_2_5),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "Choose \nYour Plan".toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }


  _textLoseWeightWithThePlan() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_1_2),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "Lose Weight With The Plan That Suits You Best",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.txtColor666,
          fontSize: AppFontSize.size_13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _choosePlanList() {
    return GetBuilder<ChooseYourPlanController>(
      id: Constant.idChooseYourPlanList,
      builder: (logic) {
        return Container(
          margin: EdgeInsets.only(bottom: AppSizes.height_2_5),
          child: ListView.builder(
            itemCount: logic.chooseYourPlanList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext buildContext, int index) {
              return _itemChoosePlanList(index, logic.chooseYourPlanList);
            },

          ),
        );
      },
    );
  }



  _itemChoosePlanList(int index, List<ChooseYourPlanData> chooseYourPlanList) {
    return InkWell(
      onTap: () {
        _chooseYourPlanController.onChooseYourPlanClick(index);

        Future.delayed(const Duration(milliseconds: 100), () {
          Get.toNamed(AppRoutes.chooseWeight);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: (index == _chooseYourPlanController.selectedChoosePlanIndex)
                ? AppColor.primary
                : AppColor.grayLight,
            borderRadius: BorderRadius.circular(100.0)),
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.width_8_5, vertical: AppSizes.height_3_5),
        margin: EdgeInsets.only(
            left: AppSizes.width_2_8,
            right: AppSizes.width_2_8,
            bottom: AppSizes.height_1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Constant.getAssetIcons() + chooseYourPlanList[index].planImage,
              height: AppSizes.height_3_7,
              width: AppSizes.height_3_7,
              color:
              (index == _chooseYourPlanController.selectedChoosePlanIndex)
                  ? AppColor.white
                  : AppColor.black,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.width_5_5),
                child: Text(
                  chooseYourPlanList[index].planName!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: (index ==
                        _chooseYourPlanController.selectedChoosePlanIndex)
                        ? AppColor.white
                        : AppColor.black,
                    fontSize: AppFontSize.size_12_5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (index == _chooseYourPlanController.selectedChoosePlanIndex) ...{
              Icon(
                Icons.check_circle_rounded,
                color: AppColor.white,
                size: AppSizes.height_3_5,
              ),
            }
          ],
        ),
      ),
    );
  }
}