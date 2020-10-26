import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/src/services/new_service.dart';
import 'package:news_provider/src/widgets/newlist_widget.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newService = Provider.of<NewService>(context);
    return Scaffold(
      body: (newService.headlines.length != 0) 
        ? NewsList(newService.headlines)
        : Center(child: CircularProgressIndicator())
    );
  }

  @override
  bool get wantKeepAlive => true;
}