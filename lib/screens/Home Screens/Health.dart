
import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Health extends StatefulWidget {
  static String routeName='/Health';
  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {

  @override
  Widget build(BuildContext context) {

    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.healthStream, context);
  }
}