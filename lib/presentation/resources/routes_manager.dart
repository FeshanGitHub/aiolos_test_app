import 'package:aiolos/presentation/home/binding/home_screen_binding.dart';
import 'package:get/get.dart';
import '../home/view/home_screen.dart';
import '../login/binding/login_binding.dart';
import '../login/view/login.dart';

class RoutesManager {
  static String loginRoute = "/login";
  static String homeRoute = "/home";

  static String getLoginRoute() => loginRoute;
  static String getHomeRoute() => homeRoute;

  static List<GetPage> routes = [
    GetPage(
        name: loginRoute, page: () => const Login(), binding: LoginBinding()),
    GetPage(name: homeRoute, page: () => const Home(), binding: HomeBinding()),
  ];
}
