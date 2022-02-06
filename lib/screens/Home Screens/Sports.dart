import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sports extends StatefulWidget {
  static String routeName='/Sports';

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> {

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.sportsStream, context);
  }
}
