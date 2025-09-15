// news_cubit.dart
import 'package:balad/home_screen/data/repos/news_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:balad/home_screen/data/models/news.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;

  NewsCubit(this.newsRepo) : super(NewsInitial());

  Future<void> fetchCountryNews(String cca2) async {
    try {
      emit(NewsLoading());

      final newsList = await newsRepo.getAllCountryNews(cca2);

      emit(NewsLoaded(newsList));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
