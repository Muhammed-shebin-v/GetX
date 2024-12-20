import 'package:get/get.dart';

class ReactiveController extends GetxController {
  var name = ''.obs;

  void changeName(String newName){
    name.value = newName;
  }
  
}