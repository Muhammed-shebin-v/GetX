import 'package:flutter/material.dart';
import 'package:getx/controller/api.dart';
import 'package:getx/controller/getx.dart';
import 'package:get/get.dart';
import 'package:getx/controller/reactive.dart';

void main() {
  Get.lazyPut<ApiService>(() => ApiService());
  runApp(GetX());
}

class GetX extends StatelessWidget {
  final themeController = Get.put(ContainerController());
  GetX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
          title: 'getx',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
          themeController.flag.value ? ThemeMode.dark : ThemeMode.light,
          home: CounterScreen());
    });
  }
}

class CounterScreen extends StatelessWidget {
   final  themeController = Get.put(ContainerController());
   final  controller = Get.put(CounterController());
  CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ApiScreen());
              },
              icon: const Icon(Icons.arrow_forward_ios_sharp))
        ],
        title: const Text('GetX'),
      ),
      body: Center(
        child: 
            Obx(() => Text(
                  '${controller.count}',
                  style: const TextStyle(fontSize: 50),
                )),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                controller.increment();
              }),
          const SizedBox(height: 20,),
          FloatingActionButton(
              child: const Icon(Icons.dark_mode),
              onPressed: () {
                themeController.darkmode();
              }),
        ],
      ),
    );
  }
}

class ApiScreen extends StatelessWidget {
  final ApiService api = Get.find();
  ApiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(CounterScreen());
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const ReactiveScreen());
              },
              icon: const Icon(Icons.arrow_forward_ios_sharp))
        ],
        title: const Text('Dependecy Injection'),
      ),
      body: Center(
        child: FutureBuilder(
            future: api.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Text('${snapshot.data}');
              } else {
                return const Text('error');
              }
            }),
      ),
    );
  }
}

class ReactiveScreen extends StatelessWidget {
  const ReactiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ReactiveController reactive = Get.put(ReactiveController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(ApiScreen());
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: const Text('Reactive StateManagment'),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(reactive.name.toString())),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: reactive.changeName,
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Name'),
                )
              ],
            ),
          ),
        ),
    );
  }
}
