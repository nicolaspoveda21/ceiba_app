import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_bloc.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_event.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_state.dart';
import 'package:flutter_application/presentation/widgets/post_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({super.key, required this.user});
  final UserModel user;

  static Widget builder(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as UserModel;

    return BlocProvider<PostBloc>(
      create: (context) => PostBloc()..add(PostsInitialEvent(arg.id)),
      child: UserPostsScreen(user: arg),
    );
  }

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publicaciones de ${widget.user.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 8),
                Text(widget.user.phone),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey),
                SizedBox(width: 8),
                Text(widget.user.email),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PostLoadedState) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return PostCard(post: post);
                      },
                    );
                  } else {
                    return Center(child: Text('Error al cargar publicaciones'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
