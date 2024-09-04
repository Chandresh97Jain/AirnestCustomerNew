import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/BlogsScreen/blog_list_model.dart';


class BlogsListController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    blogsListApi();
  }

  final blogsList = <BlogListModel>[].obs;
  Future blogsListApi() async {
    blogsList.clear();
    try {
      isLoading(true);


      var response = await ApiService().blogList();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        blogsList.value = dataList.map((json) => BlogListModel.fromJson(json)).toList();

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
