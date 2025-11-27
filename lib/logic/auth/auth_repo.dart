import 'package:dio/dio.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/core/network/api_exceptions.dart';
import 'package:docdoc/core/network/api_services.dart';
import 'package:docdoc/core/utils/pref_helper.dart';
import 'package:docdoc/logic/models/user_model.dart';
// import 'package:docdoc/logic/auth/user_model.dart';

class AuthRepo {
  final ApiServices apiServices = ApiServices();
  UserModel _currentUser = UserModel();
  UserModel get currentUser => _currentUser;


  ///login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiServices.post('auth/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  ///signup
  Future<UserModel?> signup(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phone,
  ) async {
    try {
      final response = await apiServices.post('auth/register', {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'gender': 0,
        'password_confirmation': passwordConfirmation,
      });

      if (response is ApiError) {
        throw response;
      }
      final user = UserModel.fromJson(response['data']);

      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  ///Get Profile Data
  Future<UserModel?> getProfile() async {
    try {
      final response = await apiServices.get('user/profile');

      if (response is ApiError) {
        throw response;
      }
      final data = response['data'];
      final userJson = (data is List && data.isNotEmpty) ? data.first : data;
      return UserModel.fromJson(userJson);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(massage: e.toString());
    }
  }


  ///Update user
  Future<UserModel?> updateUser(
      String name,
      String email,
      String phone,
      String password,
      String passwordConfirmation,
      ) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'gender': 0,
        'password_confirmation': passwordConfirmation,
      });
      final response = await apiServices.post('user/update', formData);

      if (response is ApiError) {
        throw response;
      }
      final data = response['data'];
      dynamic userJson;
      if (data is List && data.isNotEmpty) {
        userJson = data.first;
      } else if (data is Map<String, dynamic>) {
        userJson = data;
      } else {
        throw Exception('Unexpected data format: $data');
      }
      final user = UserModel.fromJson(userJson);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(massage: e.toString());
    }
  }


  ///Log out
  Future<void> logout() async {
    await apiServices.post('auth/logout', {});
    await PrefHelper.clearToken();
  }
}
