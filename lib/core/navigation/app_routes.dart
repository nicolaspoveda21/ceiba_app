import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/user_list_screen/screens/user_list_screen.dart';
import 'package:flutter_application/presentation/user_post_screen/screens/user_posts_screen.dart';

class AppRoutes {
  static const String userPostsScreen = '/user_posts_screen';
  static const String userListScreen = '/user_list_screen';

  static Map<String, WidgetBuilder> get routes => {
        userPostsScreen: UserPostsScreen.builder,
        userListScreen: UserListScreen.builder,
      };
}
