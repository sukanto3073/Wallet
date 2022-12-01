// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unnecessary_const, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/taskController.dart';
import '../CustomDialog/task_dialog.dart';
import '../Database/task_database.dart';
import '../ModelClass/task_model.dart';

class TaskPage extends StatefulWidget {
  final int? id;

  TaskPage({super.key, this.id});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskDbHelper _taskDatabase = TaskDbHelper();

  void createNewTask(int id) {
    showDialog(
        context: context,
        builder: ((context) {
          return TaskDialog(id);
        }));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      init: TaskController(),
      builder: ((controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            elevation: 5,
            title: const Center(child: const Text("Expense")),
          ),
          backgroundColor: Colors.blue[200],

          //Floting Action Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: () {
              createNewTask(widget.id!);
            },
            child: const Icon(Icons.add),
          ),

          body: FutureBuilder(
            future: _taskDatabase.getTaskModel(widget.id!),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>?> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went Wrong"),
                );
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                width: 100.0,
                                height: 130.0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Name: ${snapshot.data![index].name}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Total_Amount: ${snapshot.data![index].totalamount}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "paidAmount: ${snapshot.data![index].paidamount}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "unpaidamount: ${snapshot.data![index].unpaidamount}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].date}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 80,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Delete"),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    "Are you sure want to delete?"),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .red),
                                                                        onPressed:
                                                                            () {
                                                                          _taskDatabase.deleteTask(snapshot
                                                                              .data![index]
                                                                              .id!);
                                                                          Navigator.pop(
                                                                              context);

                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child: Text(
                                                                            "Yes")),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "No")),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.pink,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ])),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return Container();
            },
          ),

          //Showing all task here
        );
      }),
    );
  }
}
