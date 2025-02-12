import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/ui/choose_target_weight/controllers/choose_target_weight_controller.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/utils.dart';

class ChooseTargetWeightScreen extends StatelessWidget {
  ChooseTargetWeightScreen({super.key});

  final ChooseTargetWeightController _chooseTargetWeightController =
      Get.find<ChooseTargetWeightController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            _backarrow(),
            _textHowTallAreYou(),
            _textDescWhatYourTargetWeight(),
            _widgetTargetWeightSelection(),
            _btnNext(),
          ],
        ),
      ),
    );
  }

  _backarrow() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(
          left: AppSizes.width_6,
          right: AppSizes.width_7_5,
          top: AppSizes.height_3_7),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Utils.backWidget(),
          ),

        ],
      ),
    );
  }

  _textHowTallAreYou() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_2_5),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "What's Your \nTarget Weight?".toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _textDescWhatYourTargetWeight() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_1_2),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "Let us Know you better to help you boost your \nwork result.",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.txtColor666,
          fontSize: AppFontSize.size_12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _widgetTargetWeightSelection() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                Constant.getAssetIcons() + "icon_guide_target.webp",
                height: AppSizes.height_35,
              ),
              Expanded(child: Container()),
            ],
          ),
          GetBuilder<ChooseTargetWeightController>(
            id: Constant.idChooseTargetWeightPicker,
            builder: (logic) {
              return Container(
                margin: EdgeInsets.only(
                    left: AppSizes.width_36_5, right: AppSizes.width_24_5),
                child: Row(
                  children: [
                    if (logic.weightUnitValue == Constant.valueOne) ...{
                      Expanded(
                        child: SizedBox(
                          height: AppSizes.fullHeight ,
                          child: CupertinoPicker(
                            useMagnifier: Constant.boolValueFalse,
                            scrollController: logic.fixedExtentScrollController,
                            looping: Constant.boolValueTrue,
                            onSelectedItemChanged: (value) {
                              logic.onChangeLbsValue(value + 44);
                            },
                            itemExtent: 60.0,
                            selectionOverlay: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.8,
                                      color: AppColor.numberPickerDividerColor),
                                  bottom: BorderSide(
                                      width: 1.8,
                                      color: AppColor.numberPickerDividerColor),
                                ),
                              ),
                            ),
                            children: List.generate(
                              2157,
                              (index) {
                                index += 44;
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Utils.decimalNumberFormat(index).toString(),
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontSize: AppFontSize.size_22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    } else ...{
                      Expanded(
                        child: SizedBox(
                          height: AppSizes.fullHeight * 0.25,
                          child: CupertinoPicker(
                            useMagnifier: Constant.boolValueTrue,
                            looping: Constant.boolValueTrue,
                            scrollController: logic.fixedExtentScrollController,
                            onSelectedItemChanged: (value) {
                              logic.onChangeKgValue(value + 20);
                            },
                            itemExtent: 60.0,
                            selectionOverlay: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.8,
                                      color: AppColor.numberPickerDividerColor),
                                  bottom: BorderSide(
                                      width: 1.8,
                                      color: AppColor.numberPickerDividerColor),
                                ),
                              ),
                            ),
                            children: List.generate(
                              978,
                              (index) {
                                index += 20;
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    Utils.decimalNumberFormat(index).toString(),
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontSize: AppFontSize.size_22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    },
                    Expanded(
                      child: SizedBox(
                        height: AppSizes.fullHeight * 0.25,
                        child: CupertinoPicker(
                          useMagnifier: Constant.boolValueFalse,
                          scrollController: FixedExtentScrollController(
                              initialItem: logic.weightUnitValue),
                          looping: Constant.boolValueFalse,
                          onSelectedItemChanged: (value) {
                            logic.onChangeWeightUnit(value);
                          },
                          itemExtent: 60.0,
                          selectionOverlay: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.8,
                                    color: AppColor.numberPickerDividerColor),
                                bottom: BorderSide(
                                    width: 1.8,
                                    color: AppColor.numberPickerDividerColor),
                              ),
                            ),
                          ),
                          children: List.generate(
                            logic.weightUnitList.length,
                            (index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  logic.weightUnitList[index],
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: AppFontSize.size_22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _btnNext() {
    return Container(
      margin: EdgeInsets.only(
          bottom: AppSizes.height_2_5,
          right: AppSizes.width_14,
          left: AppSizes.width_14),
      width: AppSizes.fullWidth,
      child: TextButton(
        onPressed: () {
          _chooseTargetWeightController.onNextButtonClick();
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
            "Next".toUpperCase(),
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
