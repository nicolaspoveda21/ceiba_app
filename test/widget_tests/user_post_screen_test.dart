import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/post_model.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_bloc.dart';
import 'package:flutter_application/presentation/user_post_screen/bloc/post_state.dart';
import 'package:flutter_application/presentation/user_post_screen/screens/user_posts_screen.dart';
import 'package:flutter_application/presentation/widgets/post_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPostBloc extends Mock implements PostBloc {}

void main() {
  late MockPostBloc mockPostBloc;
  final testUser = UserModel(id: 1, name: 'Test User', username: 'test', email: 'test@test.com', phone: '123456789');

  setUp(() {
    mockPostBloc = MockPostBloc();
    when(() => mockPostBloc.stream).thenAnswer((_) => Stream.value(PostLoadingState()));
    when(() => mockPostBloc.state).thenReturn(PostLoadingState());
  });

  Widget buildTestableWidget(Widget child) {
    return BlocProvider<PostBloc>.value(
      value: mockPostBloc,
      child: MaterialApp(home: child),
    );
  }

  testWidgets('Displays loading indicator when state is PostLoadingState', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(UserPostsScreen(user: testUser)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays post list when state is PostLoadedState', (WidgetTester tester) async {
    final posts = [PostModel(userId: 1, id: 1, title: 'Test Post', body: 'This is a test post.')];
    when(() => mockPostBloc.state).thenReturn(PostLoadedState(posts));

    await tester.pumpWidget(buildTestableWidget(UserPostsScreen(user: testUser)));

    expect(find.byType(PostCard), findsOneWidget);
    expect(find.text('Test Post'), findsOneWidget);
  });

  testWidgets('Displays error message when state is PostErrorState', (WidgetTester tester) async {
    when(() => mockPostBloc.state).thenReturn(PostErrorState('Error loading posts'));

    await tester.pumpWidget(buildTestableWidget(UserPostsScreen(user: testUser)));

    expect(find.text('Error al cargar publicaciones'), findsOneWidget);
  });
}
