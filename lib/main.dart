import 'package:flutter/material.dart';
import '../controller/MyAppController.dart';
import '../model/InAppPurchaseModel.dart';


void main() {
  final InAppPurchaseModel model = InAppPurchaseModel();
  final controller = MyAppController(model);
  runApp(MyApp(controller));
}

class MyApp extends StatefulWidget {
  final MyAppController controller;

  const MyApp(this.controller, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<String> _variant = {"car", "car pro"};

  @override
  void initState() {
    super.initState();
    widget.controller.initStream(context);
    widget.controller.queryProducts(context, _variant);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("In-app Purchase")),
        body: Center(
          child: ElevatedButton(
            onPressed: widget.controller.buyProduct,
            child: const Text("Pay"),
          ),
        ),
      ),
    );
  }
}
