import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_provider/src/models/category_model.dart';
import 'package:noticias_provider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final String url =
      'https://newsapi.org/v2/top-headlines?country=co&apiKey=27455340b0f04600b803f64f312e5804';
  List<Article> headlines = [];
  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.tableTennisPaddleBall, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
      //Llena el mapa con el key de la categoría y una lista vacía
    });
    selectedCat = 'business';
  }
  getTopHeadlines() async {
    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  final String urlCategory =
      'https://newsapi.org/v2/top-headlines?country=co&apiKey=27455340b0f04600b803f64f312e5804&category=';
  String _selectedCat = 'business'; //Se puede dejar vacío
  String get selectedCat => _selectedCat;
  set selectedCat(String actual) {
    _selectedCat = actual;
    getArticlesCategory(actual);
    notifyListeners();
  }

  getArticlesCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final resp = await http.get(Uri.parse('$urlCategory$category'));
    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    //print('llegó info de $category');
    notifyListeners();
  }
}
