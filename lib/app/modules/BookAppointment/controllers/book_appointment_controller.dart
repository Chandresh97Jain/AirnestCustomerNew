import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  //TODO: Implement BookAppointmentController

  final count = 0.obs;
  final selectedDate = "".obs;
  final selectetime = "".obs;

  final selectedValue = 'Jan'.obs;
  List<String> options = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'August',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final selectedValueforAlert = '30 minutes before'.obs;
  List<String> optionsforalert = [
    "10 minutes before",
    "20 minutes before",
    "30 minutes before",
    "40 minutes before",
    "50 minutes before",
  ];
  final dayList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sa"].obs;

  final dateList = ["1", "2", "3", "4", "5", "6", "7"].obs;
  final timeList = [
    "9:30 AM",
    "10:00 AM",
    "11.00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "1:00 PM",
    "1:30 PM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
    "5:30 PM"
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
