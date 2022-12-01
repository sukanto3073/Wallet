// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/taskController.dart';

class TaskDialog extends StatelessWidget {
  int?id;
  TaskDialog(this.id);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: ((controller) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      controller: controller.name,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Name",
                        label: Text("Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      controller: controller.totalAmount,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "totalAmount",
                        label: Text("totalAmount"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      controller: controller.paidAmount,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "paidAmount",
                        label: Text("paidAmount"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: ()  {
                      controller.submmit_data(context,id!);

                    },
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
