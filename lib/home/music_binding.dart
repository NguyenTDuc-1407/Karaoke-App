import 'package:get/get.dart';
import 'package:music_app/home/music_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MusicController());
  }
}
