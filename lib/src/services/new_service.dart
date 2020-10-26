
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_provider/src/models/category_model.dart';
import 'package:news_provider/src/models/new_model.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'aba6c8a4d58447859465cae63ff54dea';

class NewService with ChangeNotifier {

  String _selectedCategory = 'business';
  bool _isLoading = true;
  List<Article> headlines = [];
  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyballBall, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewService() {
    this.getTopHeadLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  bool get isLoading => this._isLoading;

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String value) {
    this._selectedCategory = value;
    this._isLoading = true;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get articleCategorySelected => this.categoryArticles[this.selectedCategory];

  Future<void> getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final response = await http.get(url);
    final newsModel = newsModelFromJson(response.body); 
    this.headlines.addAll(newsModel.articles);
    notifyListeners();
  }

  Future getArticlesByCategory(String category) async {
    if(this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final response = await http.get(url);
    final newsModel = newsModelFromJson(response.body); 
    this.categoryArticles[category].addAll(newsModel.articles);
    this._isLoading = false;
    notifyListeners();
  }
  
}