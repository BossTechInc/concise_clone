import 'package:concise_clone/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Finance extends StatefulWidget {
  static String routeName='/Finance';
  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.financeStream, context);
  }
}
