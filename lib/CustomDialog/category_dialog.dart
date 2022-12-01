// ignore_for_file: prefer_const_constructors, duplicate_ignore, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/categoryController.dart';



class CategoryDialog extends StatelessWidget {
  const CategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.submmit_data(context);
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
