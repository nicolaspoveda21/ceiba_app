import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

class UserRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dio.get('$baseUrl/users');
      List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener usuarios');
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dio.get('$baseUrl/posts');
      List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener publicaciones');
    }
  }

  Future<List<PostModel>> fetchPostsByUser(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/posts', queryParameters: {'userId': userId});
      List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener publicaciones del usuario');
    }
  }
}
