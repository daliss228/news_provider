import 'package:flutter/material.dart';
import 'package:news_provider/src/pages/tabs_page.dart';
import 'package:news_provider/src/services/new_service.dart';
import 'package:news_provider/src/theme/mytheme.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewService())
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: mytheme,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
      ),
    );
  }
}