import 'package:injectable/injectable.dart';

import 'base_api.dart';
import 'models/user/user.dart';

@lazySingleton
class AuthenticateApi extends BaseApi {
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final url = 'authenticate/login?username=$username&password=$password';
    final user = await getData(url, User());
    return user;
  }
}
