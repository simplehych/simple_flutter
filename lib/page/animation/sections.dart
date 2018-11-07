// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Raw data for the animation demo.

import 'package:flutter/material.dart';
import 'dart:math';

const List randomColors = [
  Colors.indigo,
  Colors.blue,
  Colors.grey,
  Colors.amber,
  Colors.red,
  Colors.brown,
  Colors.green
];

class SectionDetail {
  const SectionDetail({
    this.id,
    this.title,
    this.subtitle,
    this.imageAsset,
    this.imageAssetPackage,
  });

  final int id;
  final String title;
  final String subtitle;
  final String imageAsset;
  final String imageAssetPackage;
}

class Section {
  const Section({
    this.title,
    this.backgroundAsset,
    this.backgroundAssetPackage,
    this.leftColor,
    this.rightColor,
    this.details,
  });

  final String title;
  final String backgroundAsset;
  final String backgroundAssetPackage;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator ==(Object other) {
    if (other is! Section) return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

getSections(List dataList) {
  return dataList.map<Section>((data) {
    return new Section(
        title: data["name"],
        leftColor: randomColors[Random.secure().nextInt(randomColors.length)],
        rightColor: randomColors[Random.secure().nextInt(randomColors.length)],
        backgroundAsset: 'products/earrings.png',
        backgroundAssetPackage: "flutter_gallery_assets",
        details: <SectionDetail>[
          SectionDetail(
              id: data["id"],
              title: data["name"],
              subtitle: getDescription(data["name"]),
              imageAsset: 'products/earrings.png',
              imageAssetPackage: "flutter_gallery_assets"),
        ]);
  }).toList();
}

getDescription(String name) {
  String des = "";
  switch (name) {
    case "鸿洋":
      des = "生命不息，奋斗不止，万事起于忽微，量变引起质变";
      break;
    case "郭霖":
      des = "每当你在感叹，如果有这样一个东西就好了的时候，请注意，其实这是你的机会...";
      break;
    case "玉刚说":
      des = "有创新精神的Android技术分享者";
      break;
    case "承香墨影":
      des = "";
      break;
    case "Android群英传":
      des = "";
      break;
    case "code小生":
      des = "";
      break;
    case "谷歌开发者":
      des = "";
      break;
    case "奇卓社":
      des = "";
      break;
    case "美团技术团队":
      des = "";
      break;
    case "GcsSloop":
      des = "一名来自2.5次元的魔法师，Android自定义View系列文章作者，非著名程序员";
      break;
    case "互联网侦察":
      des = "";
      break;
  }
  if (des.isEmpty) {
    des = "这是一位大牛，请深入了解";
  }
  return des;
}
