import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TechScience extends StatefulWidget {
  static String routeName='/TechScience';
  @override
  State<TechScience> createState() => _TechScienceState();
}

class _TechScienceState extends State<TechScience> {

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.techStream, context);
  }
}
