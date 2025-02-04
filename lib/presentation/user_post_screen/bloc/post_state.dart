import 'package:equatable/equatable.dart';
import '../../../../data/models/post_model.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;

  PostLoadedState(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
