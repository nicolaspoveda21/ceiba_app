import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitialEvent extends PostEvent {
  final int userId;

  PostsInitialEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
