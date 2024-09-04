import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/BookingSummary/model/card_list_model.dart';

class SavedCardController extends GetxController {
  //TODO: Implement SavedCardController

  final TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  final count = 0.obs;
  final isChecked = false.obs;
  final obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.toggle();
    update();
  }

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    cardListApi();
  }

  final cardList = <CardListModel>[].obs;

  Future cardListApi() async {
    cardList.clear();
    try {
      isLoading(true);

      var response = await ApiService().cardListApi();

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        cardList.value =
            dataList.map((json) => CardListModel.fromJson(json)).toList();

        update();
        isLoading(false);
      } else if (response['status'] == false) {
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  final isLoadingAddCard = false.obs;

  final isLoadingRemoveCard = false.obs;

  Future addCardApi() async {
    cardList.clear();
    try {
      isLoadingAddCard(true);

      var response = await ApiService().addCard(
          cardHolderNameController.text,
          cardNumberController.text,
          monthController.text,
          yearController.text,
          cvvController.text);

      if (response['status'] == true) {
        cardListApi();

        cardHolderNameController.clear();
        cardNumberController.clear();
        monthController.clear();
        yearController.clear();

        cvvController.clear();

        ToastClass.showToast(
          '${response['message']}',
        );
        isLoadingAddCard(false);
      } else if (response['status'] == false) {
        ToastClass.showToast(
          '${response['message']}',
        );
        isLoadingAddCard(false);
        update();
      }
    } finally {
      isLoadingAddCard(false);
      update();
    }
  }

  Future cardRemove({cardId}) async {
    try {
      isLoadingRemoveCard(true);

      var response =
          await ApiService().cardRemoveApi(cardId: cardId.toString());

      if (response['status'] == true) {
        cardListApi();

        ToastClass.showToast(
          '${response['message']}',
        );
        isLoadingRemoveCard(false);
      } else if (response['status'] == false) {
        ToastClass.showToast(
          '${response['message']}',
        );
        isLoadingRemoveCard(false);
        update();
      }
    } finally {
      isLoadingRemoveCard(false);
      update();
    }
  }

  void onSubmitSaveCard() {
    int currentYear = DateTime.now().year;

    if (cardNumberController.text.isEmpty) {
      ToastClass.showToast('Enter card number');
    } else if (monthController.text.isEmpty) {
      ToastClass.showToast('Enter month');
    } else if (int.tryParse(monthController.text) == null ||
        int.parse(monthController.text) > 12 ||
        int.parse(monthController.text) < 1) {
      ToastClass.showToast('Enter a valid month (01-12)');
    } else if (yearController.text.isEmpty) {
      ToastClass.showToast('Enter year');
    } else if (int.tryParse(yearController.text) == null ||
        int.parse(yearController.text) < currentYear) {
      ToastClass.showToast(
          'Enter a valid year (not lower than the current year)');
    } else if (cvvController.text.isEmpty) {
      ToastClass.showToast('Enter CVV');
    } else if (cardHolderNameController.text.isEmpty) {
      ToastClass.showToast("Enter card holder's name");
    } else {
      addCardApi();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
