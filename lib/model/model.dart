import 'package:flutter/material.dart';

class Control {
  Control(this.title, this.description, this.image,
      [this.status, this.displayType, this.subItems]);

  factory Control.fromJson(Map<dynamic, dynamic> json) {
    return Control(json['title'], json['description'], json['image'],
        json['status'], json['displayType'], json['subItems']);
  }

  final String title;
  final String description;
  final String image;
  final String status;

  /// Need to mention this when samples directly given without any sub category
  /// mention as card/fullView
  /// by default it will taken as "fullView"
  final String displayType;
  List<dynamic> sampleList;
  List<dynamic> childList;
  List<dynamic> subItems;
}

class SubItem {
  SubItem(
      [this.type,
      this.displayType,
      this.title,
      this.key,
      this.codeLink,
      this.description,
      this.status,
      this.subItems]);

  factory SubItem.fromJson(Map<dynamic, dynamic> json) {
    return SubItem(
      json['type'],
      json['displayType'],
      json['title'],
      json['key'],
      json['codeLink'],
      json['description'],
      json['status'],
      json['subItems'],
    );
  }

  /// type given as parent/child/sample.
  /// if "parent" is given then primary tab and secondary tab both come.
  /// for "parent", "child" type must be give to subItems(next hierarchy).
  /// if "child" is given only primary tab will come.
  /// if "sample" is given no tab will come.
  /// by default it taken as "sample".
  /// Note: In all cases displayType is given as "fullView", additionally sample's tab will come.
  final String type;

  /// Mention the samples layout.
  /// displayType given as card/fullView.
  /// by default it taken as "fullView".
  /// Note: Need to mention this when on display type is child.
  final String displayType;

  /// Need to mention in all type
  final String title;

  /// Below values need to give when type is "sample"
  final String key;
  final String codeLink;
  final String description;
  final String status;

  ///No need to give when type is "sample"
  List<dynamic> subItems;
}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.yValue2,
    this.yValue3,
    this.pointColor,
    this.size,
    this.text,
  });

  final dynamic x;
  final num y;
  final dynamic xValue;
  final num yValue;
  final num yValue2;
  final num yValue3;
  final Color pointColor;
  final num size;
  final String text;
}
