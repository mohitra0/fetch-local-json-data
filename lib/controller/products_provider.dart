import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorbin/utils/const.dart';

class ProductProvider extends ChangeNotifier {
  Map<String, dynamic>? products;
  num totalMoney = 0;
  getProducts() async {
    products = json.decode(await rootBundle.loadString(AppConstant.pathFile));
    notifyListeners();
  }

  addProducts(num value, String productKey, int index) async {
    totalMoney = totalMoney + value;
    products![productKey][index]['bought'] =
        products![productKey][index]['bought'] == null
            ? 1
            : products![productKey][index]['bought'] + 1;
    notifyListeners();
  }

  removeProducts(num value, String productKey, int index) async {
    totalMoney = totalMoney - value;
    products![productKey][index]['bought'] =
        products![productKey][index]['bought'] - 1;
    notifyListeners();
  }

  buyProducts() async {
    num? max = 0;
    num? maxIndex = 0;
    String? getkey;
    for (int i = 0; i < products!.length; i++) {
      var key = products!.keys.elementAt(i);
      for (int i = 0; i < products![key].length; i++) {
        products![key][i]['bestseller'] = null;
        if (products![key][i]['bought'] != null &&
            products![key][i]['bought'] > max) {
          max = products![key][i]['bought'];
          getkey = key;
          maxIndex = i;
        }
        products![key][i]['bought'] = 0;
      }
    }
    totalMoney = 0;
    products![getkey][maxIndex]['bestseller'] = true;
    notifyListeners();
  }
}
