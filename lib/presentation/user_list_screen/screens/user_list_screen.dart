import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_bloc.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_event.dart';
import 'package:flutter_application/presentation/user_list_screen/bloc/user_state.dart';
import 'package:flutter_application/data/models/user_model.dart';
import 'package:flutter_application/data/repositories/user_repository.dart';
import 'package:flutter_application/presentation/widgets/user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(userRepository: UserRepository())..add(UserInitialEvent()),
      child: UserListScreen(),
    );
  }

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _filterUsers(String query) {
    context.read<UserBloc>().add(FilterUsersEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prueba de Ingreso')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Filtrar usuarios',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterUsers,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserFilteredState) {
                    return _buildUserList(state.filteredUsers);
                  } else if (state is UserLoadedState) {
                    return _buildUserList(state.users);
                  } else {
                    return Center(child: Text('Error al cargar usuarios'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<UserModel> users) {
    return users.isEmpty
        ? Center(child: Text('List is empty'))
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserCard(
                user: user,
              );
            },
          );
  }
}
