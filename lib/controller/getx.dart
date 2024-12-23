import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;

  increment() {
    count++;
  }
}
class ContainerController extends GetxController{
  var flag = false.obs;

  darkmode(){
    flag.value = !flag.value;
    Get.changeThemeMode(flag.value ? ThemeMode.dark: ThemeMode.light);
  }
}
