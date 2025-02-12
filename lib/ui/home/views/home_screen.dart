import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/home/controllers/home_controller.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/utils.dart';

import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../me/views/me_screen.dart';
import '../../plan/views/plan_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _homeController.onWillPop();
        return false; // Prevent default back button behavior
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          GetBuilder<HomeController>(
            id: Constant.idHomePage,
            builder: (logic) {
              return Scaffold(
                backgroundColor: AppColor.white,
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _widgetTopBar(logic),
                            _widgetPageView(logic),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: _bottomNavigationBar(logic),
              );
            },
          ),
        ],
      ),
    );
  }

  _widgetTopBar(HomeController logic) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.width_5,
        vertical: AppSizes.height_1,
      ),
      child: Row(
        children: [
          Expanded(
            child: AutoSizeText(
              (logic.currentIndex == 0)
                  ? "Eva Fitness"
                  : (logic.currentIndex == 1)
                      ? "Me"
                      : "Me",
              style: TextStyle(
                color: AppColor.black,
                fontSize: AppFontSize.size_16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: AppSizes.width_1),
          if (logic.currentIndex == 0) ...{
            GetBuilder<HomeController>(
              id: Constant.idCurrentWaterGlass,
              builder: (logic) {
                return InkWell(
                  onTap: () {
                    if (Utils.isWaterTrackerOn()) {
                      Get.toNamed(AppRoutes.waterTracker,
                          arguments: [logic.currentGlass]);
                      logic.currentWaterGlass();
                    } else {
                      Get.toNamed(AppRoutes.turnOnWater,
                          arguments: [logic.currentGlass]);
                    }
                  },
                  child: badge.Badge(
                    badgeAnimation: const badge.BadgeAnimation.scale(
                      animationDuration: Duration(milliseconds: 200),
                    ),
                    badgeStyle: badge.BadgeStyle(
                      badgeColor: AppColor.commonBlueColor,
                      shape: badge.BadgeShape.circle,
                      padding: EdgeInsets.all(AppSizes.width_2),
                    ),
                    badgeContent: Text(
                      logic.currentGlass.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: AppFontSize.size_9,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    child: SizedBox(
                      height: AppSizes.height_5_5,
                      width: AppSizes.height_5,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: AppSizes.height_0_5),
                            child: CircularProgressIndicator(
                              backgroundColor: AppColor.commonBlueLightColor,
                              value: logic.currentGlass! / 8,
                              valueColor: const AlwaysStoppedAnimation(
                                  AppColor.commonBlueColor), //fixed color
                              strokeWidth: AppSizes.width_1_2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppSizes.width_2_5,
                              right: AppSizes.width_2_5,
                              bottom: AppSizes.width_2_5,
                              top: AppSizes.width_3_5,
                            ),
                            child: Image.asset(
                              Constant.getAssetIcons() +
                                  "ic_homepage_drink.webp",
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          } else ...{
            SizedBox(height: AppSizes.height_5_5, width: AppSizes.height_5),
          },
        ],
      ),
    );
  }

  _widgetPageView(HomeController logic) {
    return Expanded(
      child: PageView(
        controller: logic.pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PlanScreen(),
          MeScreen(),
        ],
      ),
    );
  }

  _bottomNavigationBar(HomeController logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          color: AppColor.txtColor999,
          thickness: AppSizes.height_0_1,
          height: 0,
        ),
        BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          unselectedItemColor: AppColor.txtColor666,
          selectedItemColor: AppColor.primary,
          onTap: logic.changePage,
          currentIndex: logic.currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.transparent,
          selectedLabelStyle: TextStyle(
            color: AppColor.primary,
            fontSize: AppFontSize.size_12,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: TextStyle(
            color: AppColor.txtColor666,
            fontSize: AppFontSize.size_12,
            fontWeight: FontWeight.w400,
          ),
          elevation: 0,
          items: [
            _bottomNavigationBarItem(
              icon: Constant.getAssetIcons() + "ic_plan.webp",
              label: 'Plan',
              index: 0,
            ),
            _bottomNavigationBarItem(
              icon: Constant.getAssetIcons() + "ic_me.webp",
              label: 'Me',
              index: 1,
            ),
          ],
        ),
      ],
    );
  }

  _bottomNavigationBarItem({String? icon, String? label, int? index}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon!,
        height: AppSizes.height_3_3,
        color: (_homeController.currentIndex == index)
            ? AppColor.primary
            : AppColor.txtColor999,
      ),
      label: label,
    );
  }
}
