import 'package:get/get.dart';
import 'package:power_maids/app/modules/BlogsScreen/controllers/blogs_controller.dart';


class BlogsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogsListController>(
      () => BlogsListController(),
    );
  }
}
