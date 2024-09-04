import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';

class MyFavouriteController extends GetxController {
  //TODO: Implement MyFavouriteController

  final count = 0.obs;
  final isLoading = false.obs;
  final isLoadingFavUnfav =  false.obs;


  @override
  void onInit() {
    super.onInit();
    favouriteListApi();
  }

  final favList = <FaviouriteListModel>[].obs;
  var isFavorite = <String, bool>{}.obs; // Maintain favorite status per item

  Future favouriteListApi() async {
    try {
      isLoading(true);
      favList.clear();

      var response = await ApiService().favoriteList();

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        favList.value =
            dataList.map((json) => FaviouriteListModel.fromJson(json)).toList();


        for (var item in favList) {
          isFavorite[item.id.toString()] = item.isFavorite == 1;
        }

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
