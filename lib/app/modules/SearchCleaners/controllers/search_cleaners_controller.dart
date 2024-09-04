import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';

class SearchCleanersController extends GetxController {
  //TODO: Implement SearchCleanersController

  TextEditingController searchTextController = TextEditingController();

  final count = 0.obs;

  final isLoadingSearch = false.obs;
  final isLoadingFavUnfav = false.obs;

  final searchCleanerList = <RecommendedListModel>[].obs;

  var isFavorite = <String, bool>{}.obs; // Maintain favorite status per item


  Future<void> toggleFavorite(String id) async {
    // Update the UI immediately
    isFavorite[id] = !isFavorite[id]!;
    update();

    try {
      isLoadingFavUnfav(true);
      var response = await ApiService().favoriteUnfavoriteApi(id);

      if (response['status'] == true) {
        //       await Recommended_List_Api();
      }
    } finally {
      isLoadingFavUnfav(false);
    }
  }


  Future fetchSearchCleanerApi({search}) async {
    searchCleanerList.clear();
    try {
      isLoadingSearch(true);

      var response = await ApiService().searchCleanerApi(search:searchTextController.text);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        searchCleanerList.value = dataList.map((json) => RecommendedListModel.fromJson(json)).toList();

        for (var item in searchCleanerList) {
          isFavorite[item.id.toString()] = item.isFavorite == 1;
        }

        update();
        isLoadingSearch(false);
      } else if (response['status'] == false) {

        isLoadingSearch(false);
        update();
      }
    } finally {
      isLoadingSearch(false);
      update();
    }
  }




  void toggleItemSelection(String item) {
    if (recommendedmaidname.contains(item)) {
      recommendedmaidname.remove(item);
    } else {
      recommendedmaidname.add(item);
    }
  }

  bool isItemSelected(String item) {
    return recommendedmaidname.contains(item);
  }

  final recommendedmaidImages = [
    "assets/images/recommendeddemo1.png",
    "assets/images/recommendeddemo2.png",
    "assets/images/recommendeddemo3.png",
  ].obs;
  final recommendedmaidname = ["Makenzie", "Britney", "La Deitra"].obs;
  final recommendedmairating = [3, 5, 2].obs;
  final recommendedmaidmaidLocation = ["Arlington, Texas", "Stone Mountain, Georgia", "Arlington, TX"].obs;
  final recommendedmaidratehoorly = [
    "15.00",
    "12.00",
    "20.00",
  ].obs;






  @override
  void onInit() {
    super.onInit();
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
