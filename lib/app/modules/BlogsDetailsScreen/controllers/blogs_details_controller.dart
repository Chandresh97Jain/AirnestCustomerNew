import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/BlogsDetailsScreen/blog_details_model.dart';


class BlogsDetailsController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  final isLoading = false.obs;
  final blogId = ''.obs;

  @override
  void onInit() {
    blogId.value = Get.parameters['blog_id']!;
    super.onInit();
    blogsDetailsApi();
  }

  final blogsList = <BlogDetailsModel>[].obs;
  final blogsDetails = {}.obs;
  Future blogsDetailsApi() async {
    blogsList.clear();
    try {
      isLoading(true);

      var response = await ApiService().blogDetailsApi(blogId.value);

      if (response['status'] == true) {


        List dataList = response['data'].toList();
        blogsList.value = dataList.map((json) => BlogDetailsModel.fromJson(json)).toList();
         blogsDetails.value =   blogsList[0].toJson();

        blogsDetails["title"];

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
