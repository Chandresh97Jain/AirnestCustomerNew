import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'controllers/wallet_controller.dart';

class AmmountList extends StatelessWidget {
  final List amount;
  final double height;
  final double cardWidth;

  const AmmountList(
      {super.key, required this.amount, required this.height, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletController());

    final controller = WalletController();

    return SizedBox(
      height: height,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.amontList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (buildContext, index) {
            return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.ammountSilect.value = controller.amontList[index];
                },
                child: SizedBox(
                  width: cardWidth,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Obx(
                        () => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.zero,
                          color: controller.ammountSilect.value ==
                                  controller.amontList[index]
                              ? AppStyles.appThemeColor
                              : AppStyles.backgroundColor,
                          child: Center(
                              child: Text(
                                  style: TextStyle(
                                      fontFamily: "JosefinSans",
                                      color: controller.ammountSilect.value ==
                                              controller.amontList[index]
                                          ? AppStyles.backgroundColor
                                          : AppStyles.BlackColor),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  "+ \$${amount[index]}")),
                        ),
                      )),
                ));
          }),
    );
  }
}
