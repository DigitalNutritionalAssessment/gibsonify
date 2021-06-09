import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/menu.dart';
import 'package:flutter_uikit/utils/uidata.dart';

//This is to set up the widgets in the home screen

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "New Collection",
          menuColor: Color(0xff050505),
          icon: Icons.add_box,
          image: UIData.profileImage,
          items: []),
      Menu(
          title: "View Data",
          menuColor: Color(0xffc8c4bd),
          icon: Icons.folder_open,
          image: UIData.blankImage,
          items: []),
      Menu(
          title: "Add New Recipe",
          menuColor: Color(0xff7f5741),
          icon: Icons.fastfood,
          image: UIData.timelineImage,
          items: []),
      Menu(
          title: "View Recipes",
          menuColor: Color(0xffc7d8f4),
          icon: Icons.folder_open,
          image: UIData.loginImage,
          items: []),
      Menu(
          title: "Login",
          menuColor: Color(0xff261d33),
          icon: Icons.person,
          image: UIData.dashboardImage,
          items: []),
      Menu(
          title: "Settings",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.settings,
          image: UIData.settingsImage,
          items: []),
//      Menu(
//          title: "No Item",
//          menuColor: Color(0xffe19b6b),
//          icon: Icons.not_interested,
//          image: UIData.blankImage,
//          items: ["No Search Result", "No Internet", "No Item 3", "No Item 4"]),
//      Menu(
//          title: "Login",
//          menuColor: Color(0xffddcec2),
//          icon: Icons.payment,
//          image: UIData.paymentImage,
//          items: []),
    ];
  }
}
