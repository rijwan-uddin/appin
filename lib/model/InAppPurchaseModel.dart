import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseModel {
  late InAppPurchase _inAppPurchase;

  InAppPurchaseModel() {
    _inAppPurchase = InAppPurchase.instance;
  }

  InAppPurchase get inAppPurchase => _inAppPurchase;
}
