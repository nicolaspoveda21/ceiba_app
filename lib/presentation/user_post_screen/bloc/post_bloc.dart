import 'package:flutter_application/presentation/user_post_screen/bloc/post_event.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_state.dart';
import 'package:flutter_application/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserRepository userRepository = UserRepository();

  PostBloc() : super(PostLoadingState()) {
    on<PostsInitialEvent>(_onPostsInitial);
  }

  Future<void> _onPostsInitial(PostsInitialEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      final posts = await userRepository.fetchPostsByUser(event.userId);
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState('Error al cargar publicaciones'));
    }
  }
}
