import 'package:flutter/material.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';

class PriceforAirbnb extends StatelessWidget {

  final String? title;
  final String? totalprice;
  final String? price;
  final String? counttext;
    

  const PriceforAirbnb({Key? key , this.title,this.totalprice, this.price, this.counttext }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Textwidget(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            text: title,),
          Row(children: [
            Textwidget(text: price,color: AppStyles.appThemeColor,),
            const SizedBox(width: 5,),
            Image.asset("assets/icons/cancelicon.png",scale: 6,color: AppStyles.appThemeColor,),

            const SizedBox(width: 5,),
        
        
            Textwidget(text: counttext,color: AppStyles.appThemeColor,),
        
        
          ],)
        ],),
      ),
      Textwidget(text: totalprice,fontWeight: FontWeight.w700,)
    ],);
  }
}
