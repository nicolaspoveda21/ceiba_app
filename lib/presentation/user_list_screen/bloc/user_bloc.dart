import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  List<UserModel> allUsers = [];

  UserBloc({required this.userRepository}) : super(UserLoadingState()) {
    on<UserInitialEvent>(_onInitialEvent);
    on<FilterUsersEvent>(_onFilterUsers);
  }

  Future<void> _onInitialEvent(UserInitialEvent event, Emitter<UserState> emit) async {
    try {
      final List<UserModel>? cachedUsers = await _getUsersFromLocalStorage();
      if (cachedUsers != null) {
        allUsers = cachedUsers;
        emit(UserLoadedState(cachedUsers));
      } else {
        emit(UserLoadingState());
        try {
          final users = await _fetchUsers();
          allUsers = users;
          emit(UserLoadedState(users));
        } catch (e) {
          emit(UserErrorState('Error al cargar usuarios'));
        }
      }
    } catch (e) {
      emit(UserErrorState('Error al cargar usuarios'));
    }
  }

  void _onFilterUsers(FilterUsersEvent event, Emitter<UserState> emit) {
    final filteredUsers =
        allUsers.where((user) => user.name.toLowerCase().contains(event.query.toLowerCase())).toList();
    emit(UserFilteredState(filteredUsers));
  }

  Future<List<UserModel>?> _getUsersFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString('users');
    if (usersJson != null) {
      final List<dynamic> userList = jsonDecode(usersJson);
      return userList.map((json) => UserModel.fromJson(json)).toList();
    }
    return null;
  }

  Future<List<UserModel>> _fetchUsers() async {
    return await userRepository.fetchUsers();
  }
}
