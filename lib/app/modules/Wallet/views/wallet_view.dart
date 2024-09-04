import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/Wallet/ammount_list.dart';
import 'package:power_maids/app/modules/Wallet/controllers/wallet_controller.dart';



class WalletView extends GetView<WalletController> {
  const WalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          titleSpacing: 15,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: 'Wallet',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/WalletBackground.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                    Textwidget(
                                      text: "Your total wallet balance",
                                      color: AppStyles.GraylightTextColor,
                                    ),
                                    Textwidget(
                                      text: "\$546.00",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/icons/WalletIcon.png",
                                height: 40,
                              )
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Card(
                            margin: EdgeInsets.zero,
                              color: AppStyles.backgroundColor,
                              child: OutlineButton(
                                tectcolor: AppStyles.appThemeColor,
                                bordercolor: AppStyles.appThemeColor,

                                text: 'Withdraw wallet balance', onPressed: () {  },))
                         ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 20),
                child: Column(
                  children: [
                    Row(children: [
                      Textwidget(text: "Add money to",fontSize: 17,fontWeight: FontWeight.w700,),
                      const SizedBox(width: 5,),
                      Textwidget(text: "Airnests wallet",fontSize: 17,fontWeight: FontWeight.w700,color: AppStyles.appThemeColor,),
                    ],),
                    const SizedBox(height: 5,),
                    TextFieldDesigned(
          
                      prefixIcon: Image.asset(
                        "assets/icons/doalericon.png",
                        scale: 3.5,
                        height: 50,
                      ),
                      hintText: "Add Amount",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10,),
                    AmmountList(amount: controller.amontList, height: 50, cardWidth: 100,),
                    SizedBox(height: MediaQuery.of(context).size.height/10,),
          
          
                    MyButton(text: 'Proceed to add amount', onPressed: () {  }, color: AppStyles.appThemeColor, TextColor: AppStyles.backgroundColor,)
          
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
