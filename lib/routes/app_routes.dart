import 'package:flutter/material.dart';
import 'package:skill_swap/common/widgets/drawer_page.dart';
import 'package:skill_swap/screens/Auth/login_screen.dart';
import 'package:skill_swap/screens/Basic/basic_complete.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/liquid_swipe.dart';

typedef RouteWidgetBuilder = Widget Function(BuildContext);

final Map<String, RouteWidgetBuilder> appRoutes = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  DrawerPage.routeName: (context) => const DrawerPage(),
  BasicComplete.routeName: (context) => const BasicComplete(),
};
