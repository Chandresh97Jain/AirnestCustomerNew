import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';


class RecommendedViewAllController extends GetxController {
  //TODO: Implement RecommendedViewAllController

  final count = 0.obs;
  var isFavorite = <String, bool>{}.obs; // Maintain favorite status per item





  final isLoading =  false.obs;
  final isLoadingFavUnFav =  false.obs;

  @override
  void onInit() {
    super.onInit();
    recommendedListApi();
  }

  final recommendedList = <RecommendedListModel>[].obs;

  Future recommendedListApi() async {
    recommendedList.clear();
    try {
      isLoading(true);

      var response = await ApiService().recommendedListApi();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        recommendedList.value = dataList.map((json) => RecommendedListModel.fromJson(json)).toList();

        for (var item in recommendedList) {
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

  // Future Faviourite_Unfaviourite(cleaner_co_host_id) async {
  //   try {
  //     isLoadingLike(true);
  //
  //     var response = await ApiService().Favorite_Unfavorite(cleaner_co_host_id);
  //
  //     if (response['status'] == true) {
  //
  //       recommendedListApi();
  //       update();
  //       isLoadingLike(false);
  //     } else if (response['status'] == false) {
  //
  //       isLoadingLike(false);
  //       update();
  //     }
  //   } finally {
  //     isLoadingLike(false);
  //     update();
  //   }
  // }


  Future<void> toggleFavorite(String id) async {
    // Update the UI immediately
    isFavorite[id] = !isFavorite[id]!;
    update();

    try {
      isLoadingFavUnFav(true);
      var response = await ApiService().favoriteUnfavoriteApi(id);

      if (response['status'] == true) {
        //       await Recommended_List_Api();
      }
    } finally {
      isLoadingFavUnFav(false);
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
