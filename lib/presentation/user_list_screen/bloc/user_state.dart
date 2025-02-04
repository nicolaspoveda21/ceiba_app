import 'package:equatable/equatable.dart';
import '../../../../data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> users;

  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UserFilteredState extends UserState {
  final List<UserModel> filteredUsers;

  UserFilteredState(this.filteredUsers);

  @override
  List<Object?> get props => [filteredUsers];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
