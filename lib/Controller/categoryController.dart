
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Database/category_database.dart';
import '../ModelClass/category_model.dart';



class CategoryController extends GetxController {
  RxBool loader = false.obs;
  final CategoryDbHelper _categoryDbHelper = CategoryDbHelper();
  final TextEditingController name = TextEditingController();


  Random random = Random();


  void submmit_data(BuildContext context) async {
    loader.value = true;
    update();
    var category = Category(
      id: random.nextInt(100),
      name: name.text,
    );
    await _categoryDbHelper.addCategory(category);
    Navigator.pop(context);
    name.clear();
    loader.value = false;
    update();
  }
}
