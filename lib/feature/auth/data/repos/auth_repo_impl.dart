import 'package:banking_app/constants.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final Api _api;
  AuthRepoImpl(this._api);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await _api.post(
        token: null,
        url: '$baseUrl/auth/login',
        body: {'email': email, 'password': password, 'fcmToken': 'nbjkj'},
      );

      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
