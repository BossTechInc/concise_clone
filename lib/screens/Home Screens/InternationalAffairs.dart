import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class International extends StatefulWidget {
  static String routeName='/InternationalAffairs';

  @override
  State<International> createState() => _InternationalState();
}

class _InternationalState extends State<International> {
  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.internationalStream, context);

  }
}
