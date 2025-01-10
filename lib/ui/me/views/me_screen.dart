import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/me/controllers/me_controller.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
import '../../../utils/color.dart';

class MeScreen extends StatelessWidget {
  MeScreen({super.key});
  final MeController _meController = Get.find<MeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.height_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _commonTitleText("General Settings"),
          _spaceWidget(h: AppSizes.height_3_3),
          Row(
            children: [
              Expanded(
                child: _commonFieldText(
                  "Turn On Water Tracker",
                  "ic_set_water.webp",
                  null,
                  Constant.boolValueTrue,
                  onTap: () {},
                ),
              ),
              GetBuilder<MeController>(
                id: Constant.idMeTurnOnWaterTrackerSwitch,
                builder: (logic) {
                  return Container(
                    height: AppSizes.height_1,
                    width: AppSizes.height_3,
                    margin: EdgeInsets.only(
                        right: AppSizes.width_5, left: AppSizes.width_5),
                    child: Switch(
                      onChanged: (value) {
                        logic.onTurnOnWaterTrackerToggleSwitchChange(value);
                      },
                      value: logic.isTurnOnWaterTracker,
                      activeColor: AppColor.switchActivate,
                      activeTrackColor: AppColor.switchActivateTrack,
                      inactiveThumbColor: AppColor.switchInactive,
                      inactiveTrackColor: AppColor.switchInactiveTrack,
                    ),
                  );
                },
              ),
            ],
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "My Profile",
            "",
            Icons.add_box_outlined,
            Constant.boolValueFalse,
            onTap: () {
              Get.toNamed(AppRoutes.myProfile);
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _spaceWidget(),
          _dividerWidget(),
          _spaceWidget(),
          _spaceWidget(),
          _commonTitleText("Support Us"),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "Feedback",
            "",
            Icons.edit_outlined,
            Constant.boolValueFalse,
            onTap: () {},
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "Privacy policy".tr,
            "",
            Icons.visibility_outlined,
            Constant.boolValueFalse,
            onTap: () {
              _meController.loadPrivacyPolicy();
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "About Us",
            "",
            Icons.add_business_sharp,
            Constant.boolValueFalse,
            onTap: () {
              Get.toNamed(AppRoutes.about);
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "Logout",
            "",
            Icons.logout,
            Constant.boolValueFalse,
            onTap: () {
              showLogoutDialog();
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
        ],
      ),
    );
  }

  _commonTitleText(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.width_3),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _commonFieldText(String title, String asset, IconData? icon, bool isAsset,
      {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSizes.height_3,
              width: AppSizes.height_3,
              child: (isAsset)
                  ? Image.asset(
                      Constant.getAssetIcons() + asset,
                      color: AppColor.txtColor999,
                    )
                  : Icon(
                      icon,
                      color: AppColor.txtColor999,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.width_4),
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: AppFontSize.size_12_5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dividerWidget() {
    return Container(
      height: AppSizes.height_1_2,
      color: AppColor.grayLight,
      child: null,
    );
  }

  _spaceWidget({double? h}) {
    return SizedBox(
      height: h ?? AppSizes.height_2_5,
    );
  }

  showLogoutDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSizes.height_3, horizontal: AppSizes.width_6),
              child: Text(
                "Are you sure want to log out?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  child: Text(
                    "Logout".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppFontSize.size_11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    _meController.signOutFromGoogle().then((_) {
                      Get.offAllNamed(AppRoutes.signIn);
                    });
                  },
                ),
                SizedBox(width: AppSizes.width_3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
