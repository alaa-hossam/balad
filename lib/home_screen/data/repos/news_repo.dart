import 'package:balad/home_screen/data/models/news.dart';
import 'package:balad/home_screen/data/web_services/news_web_services.dart';

class NewsRepo {
  final NewsWebServices newsWebServices;

  NewsRepo(this.newsWebServices);

  Future<List<News>> getAllCountryNews(String cca2) async {
    final news = await newsWebServices.getAllCountryNews(cca2);
    return news.map<News>((json) => News.fromJson(json)).toList();
  }
}
