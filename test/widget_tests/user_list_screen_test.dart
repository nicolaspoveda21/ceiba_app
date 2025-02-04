import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_bloc.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_state.dart';
import 'package:flutter_application/presentation/user_list_screen/screens/user_list_screen.dart';
import 'package:flutter_application/presentation/widgets/user_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();
    when(() => mockUserBloc.stream).thenAnswer((_) => Stream.value(UserLoadingState()));
    when(() => mockUserBloc.state).thenReturn(UserLoadingState());
  });

  Widget buildTestableWidget(Widget child) {
    return BlocProvider<UserBloc>.value(
      value: mockUserBloc,
      child: MaterialApp(home: child),
    );
  }

  testWidgets('Displays loading indicator when state is UserLoadingState', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoadingState());

    await tester.pumpWidget(buildTestableWidget(const UserListScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays user list when state is UserLoadedState', (WidgetTester tester) async {
    final users = [UserModel(id: 1, name: 'Test User', username: 'test', email: 'test@test.com', phone: '123456789')];
    when(() => mockUserBloc.state).thenReturn(UserLoadedState(users));

    await tester.pumpWidget(buildTestableWidget(const UserListScreen()));

    expect(find.byType(UserCard), findsOneWidget);
    expect(find.text('Test User'), findsOneWidget);
  });

  testWidgets('Displays error message when state is UserErrorState', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserErrorState('Error al cargar usuarios'));

    await tester.pumpWidget(buildTestableWidget(const UserListScreen()));

    expect(find.text('Error al cargar usuarios'), findsOneWidget);
  });

  testWidgets('Displays empty list message when no users are found in UserFilteredState', (WidgetTester tester) async {
    when(() => mockUserBloc.state).thenReturn(UserFilteredState([]));

    await tester.pumpWidget(buildTestableWidget(const UserListScreen()));

    expect(find.text('List is empty'), findsOneWidget);
  });
}
