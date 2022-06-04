import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/user.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';

class AuthState {
  final String? token;
  final User? user;

  AuthState(this.token, this.user);

  bool get isLoggedIn {
    return token != null && user != null;
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(AuthState state, this.apiProvider) : super(state);
  final PodfetchApiProvider apiProvider;

  bool get isLoggedIn {
    return state.isLoggedIn;
  }

  String? get token {
    return state.token;
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await apiProvider.login({
        'email': email,
        'password': password,
      });
      state = AuthState(response.token, response.user);
      return true;
    } on DioError catch (e) {
      print(e.response?.data?.toString());
      return false;
    }
  }
}

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final podfetchApiProvider = ref.read(apiProvider);
  return AuthStateNotifier(AuthState(null, null), podfetchApiProvider);
});
