import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitialEvent extends UserEvent {}

class FilterUsersEvent extends UserEvent {
  final String query;

  FilterUsersEvent(this.query);

  @override
  List<Object?> get props => [query];
}
