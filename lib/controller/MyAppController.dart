import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../model/InAppPurchaseModel.dart';


class MyAppController {
  final InAppPurchaseModel _model;

  MyAppController(this._model);

  void initStream(BuildContext context) {
    _model.inAppPurchase.purchaseStream.listen((purchaseList) {
      _listenToPurchase(purchaseList, context);
    }, onDone: () {
      // Handle when the stream is done
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error")));
    });
  }

  // Query the store for product details
  Future<void> queryProducts(BuildContext context, Set<String> variant) async {
    final ProductDetailsResponse productDetailsResponse =
    await _model.inAppPurchase.queryProductDetails(variant);

    if (productDetailsResponse.error == null) {
      // Use the product details in the UI or store them
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error loading products")));
    }
  }

  void buyProduct() {
    // Call the model to buy the product (assuming the product is available)
    final PurchaseParam param = PurchaseParam(productDetails: ProductDetails(id: '', title: '', description: '', price: '',  currencyCode: ''));
    _model.inAppPurchase.buyConsumable(purchaseParam: param);
  }

  void _listenToPurchase(List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Purchase Pending")));
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Purchase Error")));
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Purchase Successful")));
      }

      // Complete the purchase if pending
      if (purchaseDetails.pendingCompletePurchase) {
        _model.inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  void dispose() {
    // Dispose any resources, if necessary
  }
}
