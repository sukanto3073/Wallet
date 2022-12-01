
// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Database/task_database.dart';
import '../ModelClass/task_model.dart';




class TaskController extends GetxController {

  final TaskDbHelper _taskDbHelper = TaskDbHelper();
  final TextEditingController name = TextEditingController();
  final TextEditingController totalAmount = TextEditingController();
  final TextEditingController paidAmount = TextEditingController();

  Random random = Random();

  void submmit_data(BuildContext context,int id) async {

    var unPaid= double.parse(totalAmount.text) - double.parse(paidAmount.text);
    var task = Task(
      id: random.nextInt(100),
      name: name.text,
      categoryid: id,
      totalamount: totalAmount.text,
      paidamount: paidAmount.text,
      unpaidamount: unPaid,
      date: DateFormat().add_yMd().format(DateTime.now()),


    );
    await _taskDbHelper.addTask(task);
    update();
    Navigator.pop(context);
    name.clear();
    totalAmount.clear();
    paidAmount.clear();



  }
}


