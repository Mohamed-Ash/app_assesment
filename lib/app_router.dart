import 'package:app_assesment/screens/home/page/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static List<GoRoute> get getRouter =>  [
    homePageRouter,
  ];


  static GoRoute get homePageRouter => HomePage.pageRoute;
}