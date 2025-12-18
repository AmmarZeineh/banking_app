import 'package:banking_app/constants.dart';
import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/core/models/user_model.dart';
import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/account/data/models/account_model/account_model.dart';
import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:dartz/dartz.dart';

class AccountRepoImpl implements AccountRepo {
  final Api _api;

  AccountRepoImpl(this._api);
  @override
  Future<Either<Failure, void>> createAccount({
    required CreateAccountParams createAccountParams,
  }) async {
    try {
      AccountModel accountModel = AccountModel.fromAccountParams(
        createAccountParams,
      );
      await _api.post(url: '$baseUrl/account', body: accountModel.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> listAllUsers() async {
    try {
      final response = await _api.get(url: '$baseUrl/user?skip=0&limit=10');

      final List<dynamic> rawUsers = response['data'] ?? [];

      final users = rawUsers
          .where((u) => u['roleId'] == 3)
          .map((u) => UserModel.fromJson(u).toEntity())
          .toList();

      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
