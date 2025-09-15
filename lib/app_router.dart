import 'package:balad/home_screen/data/repos/news_repo.dart';
import 'package:balad/home_screen/data/web_services/news_web_services.dart';
import 'package:balad/home_screen/logic/cubit/news_cubit.dart';

import 'home_screen/data/repos/countery_repo.dart';
import 'home_screen/data/web_services/countery_web_services.dart';
import 'home_screen/logic/cubit/country_cubit.dart';
import 'home_screen/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CounteryRepo counteryRepo;
  late CountryCubit countryCubit;
  late NewsRepo newsRepo;
  late NewsCubit newsCubit;

  AppRouter() {
    counteryRepo = CounteryRepo(CounteryWebServices());
    countryCubit = CountryCubit(counteryRepo);
    newsRepo = NewsRepo(NewsWebServices());
    newsCubit = NewsCubit(newsRepo);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => countryCubit),
              BlocProvider(create: (_) => newsCubit),
            ],
            child: HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
