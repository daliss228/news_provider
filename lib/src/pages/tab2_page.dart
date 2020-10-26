import 'package:flutter/material.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/theme/mytheme.dart';
import 'package:news_provider/src/widgets/newlist_widget.dart';
import 'package:provider/provider.dart';
import 'package:news_provider/src/services/new_service.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoryList(),
            Expanded(
              child: (newService.isLoading) 
                ? NewsList(newService.articleCategorySelected)
                : Center(child: CircularProgressIndicator())
            ),
            // Consumer<NewService>(builder: (context, provider, child) { 
            //   return Expanded(
            //   child: (provider.isLoading) 
            //     ? NewsList(provider.articleCategorySelected)
            //     : Center(child: CircularProgressIndicator())
            //   );
            // })
          ]
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categories[index].name;
          return Container(
            width: 110.0,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(category: categories[index]),
                SizedBox(height: 5.0),
                Text('${categoryName[0].toLowerCase()}${categoryName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final CategoryModel category;
  const _CategoryButton({@required this.category});

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);
    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewService>(context, listen: false);
        newService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(category.iconData, color: (newService.selectedCategory == this.category.name) ? mytheme.accentColor: Colors.black54),
      ),
    );
  }
}