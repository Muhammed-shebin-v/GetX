import 'package:flutter/material.dart';
import 'package:getx/controller/api.dart';
import 'package:getx/controller/getx.dart';
import 'package:get/get.dart';
import 'package:getx/controller/reactive.dart';

void main() {
  Get.lazyPut<ApiService>(() => ApiService());
  runApp(const GetX());
}

class GetX extends StatelessWidget {
  const GetX({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'getx',
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const ApiScreen());
              },
              icon: const Icon(Icons.arrow_forward_ios_sharp))
        ],
        title: const Text('GetX'),
      ),
      body: Center(
        child: Obx(() => Text(
              '${controller.count}',
              style: const TextStyle(fontSize: 50),
            )),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            controller.increment();
          }),
    );
  }
}

class ApiScreen extends StatelessWidget {
  const ApiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ApiService api = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(const CounterScreen());
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
              Get.to(const ApiScreen());
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
              Obx(() => Text('Name is ${reactive.name}')),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: reactive.changeName,
                decoration: const InputDecoration(hintText: 'Enter Your Name'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
