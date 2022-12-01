// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unnecessary_const, avoid_unnecessary_containers, prefer_const_constructors_in_immutables


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/Pages/task_page.dart';

import '../Controller/categoryController.dart';
import '../CustomDialog/category_dialog.dart';
import '../Database/category_database.dart';
import '../ModelClass/category_model.dart';




class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryDbHelper _categoryDbHelper = CategoryDbHelper();

  void createNewTask() {
    showDialog(
        context: context,
        builder: ((context) {
          return CategoryDialog();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: CategoryController(),
      builder: ((controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            elevation: 5,
            title: const Center(child: const Text("Category")),
          ),
          backgroundColor: Colors.blue[200],

          //Floting Action Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),

          body: FutureBuilder(
            future: _categoryDbHelper.getCategoryModel(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Category>?> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went Wrong"),
                );
              } else {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          int? id= snapshot.data![index].id;
                          Get.to(TaskPage(id: id));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/home.jpg",
                                  height: 80,
                                  width: 80,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshot.data![index].name}",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: (){

                                        showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            title: Text("Delete"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Are you sure want to delete?"),
// Emulator on Koren
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(primary: Colors.red),
                                                        onPressed: (){

                                                          _categoryDbHelper.deleteCategory(snapshot.data![index].id!);
                                                          setState(() {

                                                          });
                                                          Navigator.pop(context);

                                                        }, child: Text("Yes")),
                                                    SizedBox(width: 20,),
                                                    ElevatedButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text("No")),
                                                    SizedBox(width: 20,),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          );
                                        });
                                      },
                                      child: Icon(Icons.delete,color: Colors.pink,size: 30),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );


                    },

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 4 / 4),
                  );
                }
              }
              return Container();
            },
          ),


        );
      }),
    );
  }
}
