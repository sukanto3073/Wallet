// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.id,
    this.name,
    this.categoryid,
    this.totalamount,
    this.paidamount,
    this.unpaidamount,
    this.date,
  });

  int? id;
  String? name;
  int? categoryid;
  dynamic? totalamount;
  dynamic? paidamount;
  dynamic? unpaidamount;
  String? date;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    categoryid: json["categoryid"] == null ? null : json["categoryid"],
    totalamount: json["totalamount"] == null ? null : json["totalamount"],
    paidamount: json["paidamount"] == null ? null : json["paidamount"],
    unpaidamount: json["unpaidamount"] == null ? null : json["unpaidamount"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "categoryid": categoryid == null ? null : categoryid,
    "totalamount": totalamount == null ? null : totalamount,
    "paidamount": paidamount == null ? null : paidamount,
    "unpaidamount": unpaidamount == null ? null : unpaidamount,
    "date": date == null ? null : date,
  };
}
