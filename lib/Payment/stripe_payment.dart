import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_maids/app/modules/BidSummary/controllers/bid_summary_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

import '../app/modules/BookingSummary/controllers/booking_summary_controller.dart';

// class Payment_Gateways{
//   // final SubscriptionScreenController controller = Get.find();
//   //BuildContext? context = Get.key.currentContext;
//   final GetmemberShipId=''.obs;
//
//
//
//   Map<String, dynamic>? paymentIntent;
//
//   Future<void> makePayment({Subscription_price,memberShipId, context}) async {
//     //await dotenv.load(fileName: ".env");
//     try {
//       GetmemberShipId.value=memberShipId.toString();
//       // print('GetmemberShipId-------------------------------------${GetmemberShipId}');
//       // print('Subscription_price-------------------------------------${Subscription_price}');
//       //STEP 1: Create Payment Intent
//       paymentIntent = await createPaymentIntent('${Subscription_price}', 'INR');
//
//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
//               style: ThemeMode.light,
//               merchantDisplayName: 'Ikay'))
//           .then((value) {
//
//
//       });
//       displayPaymentSheet(context,Subscription_price.toString());
//       //STEP 3: Display Payment sheet
//
//     } catch (err) {
//       throw Exception(err);
//     }
//   }
//   calculateAmount(String amount) {
//     final calculatedAmout = (int.parse(amount)) * 100;
//     return calculatedAmout.toString();
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };
//
//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
//
//
//   displayPaymentSheet(context,Subscription_price) async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) async {
//         /* showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   Icon(
//                     Icons.check_circle,
//                     color: Colors.green,
//                     size: 100.0,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text("Payment Successful!"),
//                 ],
//               ),
//             ));*/
//         var paymentIntentId = paymentIntent!['id'];
//
//         print('paymentIntentId-------------------------${paymentIntentId}');
//         await controller.PayMembership(memberShipId: GetmemberShipId.value.toString(),transaction_id: paymentIntentId.toString(),price: Subscription_price.toString(),status: '2'.toString(),type: '0'.toString());
//
//         paymentIntent = null;
//
//       }).onError((error, stackTrace) {
//         throw Exception(error);
//       });
//
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//       AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: const [
//                 Icon(
//                   Icons.cancel,
//                   color: Colors.red,
//                 ),
//                 Text("Payment Failed"),
//               ],
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('$e');
//     }
//   }
//
//
// }


class StripePaymentHandle {

  Map<String, dynamic>? paymentIntent;
  final BookingSummaryController controller = Get.put(BookingSummaryController());

  Future<void> stripeMakePayment() async {
    print("toatl price ------------ -- ${controller.totalPrice.value}");
    double totalprice = double.parse(controller.totalPrice.value);
    try {
      paymentIntent = await createPaymentIntent(totalprice, 'USD');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      var transaction_id = paymentIntent!['id'].toString();

      controller.checkOutApi(transaction_id.toString());

      print('transaction_id-------------------------${transaction_id}');


      Fluttertoast.showToast(msg: 'Payment Succesfully Completed');
      controller.isOpenLoadingSheet.value = false;
    } on Exception catch (e) {
      if (e is StripeException) {
        controller.isOpenLoadingSheet.value = false;
        Fluttertoast.showToast(
            msg: 'Error from Stripe -- : ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error -- : ${e}');
      }
    }
  }

//create Payment
  createPaymentIntent(double amount, String currency) async {
    print("-------------payment api");
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print("----- false");
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(double amount) {
    final int calculatedAmount = (amount * 100).round();
    return calculatedAmount.toString();
  }
}

class StripePaymentHandleBid {
  Map<String, dynamic>? paymentIntent;
  final BidSummaryController controller = Get.put(BidSummaryController());
  Future<void> stripeMakePayment() async {
    print("toatl price ------------ -- ${controller.totalPrice.value}");
    double totalprice = double.parse(controller.totalPrice.value);
    try {
      paymentIntent = await createPaymentIntent(totalprice, 'USD');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      var transaction_id = paymentIntent!['id'].toString();

      controller.checkOutApi(transaction_id.toString());

      print('transaction_id-------------------------${transaction_id}');


      Fluttertoast.showToast(msg: 'Payment Succesfully Completed');
      controller.isOpenLoadingSheet.value = false;

    } on Exception catch (e) {
      if (e is StripeException) {
        controller.isOpenLoadingSheet.value = false;
        Fluttertoast.showToast(
            msg: 'Error from Stripe -- : ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error -- : ${e}');
      }
    }
  }

//create Payment
  createPaymentIntent(double amount, String currency) async {
    print("-------------payment api");
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };


      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print("----- false");
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(double amount) {
    final int calculatedAmount = (amount * 100).round();
    return calculatedAmount.toString();
  }
}


