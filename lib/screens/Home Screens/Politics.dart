import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Politics extends StatefulWidget {
  static String routeName = '/Politics';

  @override
  State<Politics> createState() => _PoliticsState();
}
class _PoliticsState extends State<Politics> {

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.politicsStream, context);
  }
}