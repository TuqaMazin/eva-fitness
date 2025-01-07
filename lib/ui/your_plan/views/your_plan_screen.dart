import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/ui/your_plan/controllers/your_plan_controller.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/utils.dart';

class YourPlanScreen extends StatelessWidget {
  YourPlanScreen({super.key});

  final YourPlanController _yourPlanController = Get.find<YourPlanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30.0,),
            _textChangeStartsToday(),
            _textYourPlanIsReady(),
            _widgetSelectedPlan(),
            Expanded(child: Container()),
            _btnGo(),
            const SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }


  _textChangeStartsToday() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_2_5),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "Change Starts \nToday!".toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _textYourPlanIsReady() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_1_2),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "Your Plan Is Ready!",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.txtColor666,
          fontSize: AppFontSize.size_12_5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _widgetSelectedPlan() {
    return Container(
      margin: EdgeInsets.only(
          top: AppSizes.height_5,
          right: AppSizes.width_5,
          left: AppSizes.width_5),
      height: AppSizes.height_41,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadow,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 10.0, //shadow
                  spreadRadius: 1.0, //spreading
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Utils.getSelectedPlanImage(
                    _yourPlanController.selectedPlanIndex),
                width: AppSizes.fullWidth,
                fit: BoxFit.fill,
              ),
            ),
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
                Image.asset(
                  Constant.getAssetIcons() + "ic_level_3.webp",
                  width: AppSizes.width_15,
                ),
                Container(
                  margin: EdgeInsets.only(top: AppSizes.height_10),
                  child: Text(
                    Utils.getSelectedPlanName(
                        _yourPlanController.selectedPlanIndex),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColor.txtColor333,
                      fontSize: AppFontSize.size_15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GetBuilder<YourPlanController>(
                  id: Constant.idYourPlanProgress,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  _btnGo() {
    return Container(
      margin:
          EdgeInsets.only(right: AppSizes.width_14, left: AppSizes.width_14),
      width: AppSizes.fullWidth,
      child: TextButton(
        onPressed: () {
          _yourPlanController.onGoButtonAndGoToSignPageClick();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColor.primary),
          elevation: WidgetStateProperty.all(2),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: AppColor.transparent, width: 0.7),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.height_1_2),
          child: Text(
            "Go !".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.size_15,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

}
