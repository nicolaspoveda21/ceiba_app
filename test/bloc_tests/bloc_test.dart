import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/data/repositories/user_repository.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_bloc.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_event.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserBloc userBloc;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userBloc = UserBloc(userRepository: mockUserRepository);
    SharedPreferences.setMockInitialValues({});
  });

  final testUsers = [UserModel(id: 1, name: 'Test User', username: 'test', email: 'test@test.com', phone: '123456789')];

  blocTest<UserBloc, UserState>(
    'Emits [UserLoadingState, UserLoadedState] when UserInitialEvent is added and users are fetched',
    build: () {
      when(() => mockUserRepository.fetchUsers()).thenAnswer((_) async => testUsers);
      return userBloc;
    },
    act: (bloc) => bloc.add(UserInitialEvent()),
    expect: () => [UserLoadingState(), UserLoadedState(testUsers)],
  );

  blocTest<UserBloc, UserState>(
    'Emits [UserFilteredState] when FilterUsersEvent is added',
    build: () {
      userBloc.allUsers = testUsers;
      return userBloc;
    },
    act: (bloc) => bloc.add(FilterUsersEvent('Test')),
    expect: () => [UserFilteredState(testUsers)],
  );

  blocTest<UserBloc, UserState>(
    'Emits [UserErrorState] when UserInitialEvent fails',
    build: () {
      when(() => mockUserRepository.fetchUsers()).thenThrow(Exception('API Error'));
      return userBloc;
    },
    act: (bloc) => bloc.add(UserInitialEvent()),
    expect: () => [UserLoadingState(), UserErrorState('Error al cargar usuarios')],
  );
}
