import 'package:concise_clone/models/menu_items.dart';
import 'package:flutter/material.dart';

class MenuItemsWidget {
  static List<MenuItemsClass> items = [newsShare, newsReadMore];
  static const newsShare = MenuItemsClass(Icons.share, "Share");
  static const newsReadMore = MenuItemsClass(Icons.read_more, "Read More");
}
