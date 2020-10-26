import 'package:flutter/material.dart';
import 'package:news_provider/src/models/new_model.dart';
import 'package:news_provider/src/theme/mytheme.dart';

class NewsList extends StatelessWidget {

  final List<Article> news;

  NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(article: this.news[index], index: index);
      }
    );
  }
}

class _New extends StatelessWidget {
  
  final Article article;
  final int index;
  const _New({@required this.article, @required  this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardTopBar(article: article, index: index),
        _CartTitle(article: article),
        _CardImage(article: article),
        _CardBody(article: article),
        _CardButtons(),
        SizedBox(height: 10.0),
        Divider()
      ],
    );
  }
}

class _CardTopBar extends StatelessWidget {

  final Article article;
  final int index;
  const _CardTopBar({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: mytheme.accentColor)),
          Text('${article.source.name}. ', style: TextStyle(color: mytheme.accentColor)),
        ],
      ),
    );
  }
}

class _CartTitle extends StatelessWidget {
  
  final Article article;
  const _CartTitle({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(article.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700))
    );
  }
}

class _CardImage extends StatelessWidget {

  final Article article;
  const _CardImage({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: (article.urlToImage != null) 
        ? FadeInImage(
          placeholder: AssetImage('assets/img/giphy.gif'),
          image: NetworkImage(article.urlToImage),
        )
        : Image(image: AssetImage('assets/img/no-image.png')),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {

  final Article article;
  const _CardBody({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(article.description != null ? article.description : ''),
    );
  }
}

class _CardButtons extends StatelessWidget {
  const _CardButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: mytheme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}