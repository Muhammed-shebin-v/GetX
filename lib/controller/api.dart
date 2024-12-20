import 'package:get/get_state_manager/get_state_manager.dart';

class ApiService extends GetxService {
Future<String> fetchData() async{
  await Future.delayed(Duration(seconds: 1));
  return 'Data From Api';
}
}