import 'package:summit_team/features/app/data/datasources/app_local_data_source.dart';
import 'package:summit_team/features/app/domain/repositories/app_repository.dart';
import 'package:summit_team/core/error/exceptions.dart';
import 'package:summit_team/core/error/failures.dart';

import 'package:dartz/dartz.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource appLocalDataSource;

  AppRepositoryImpl({required this.appLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang(String langCode) async {
    try {
      final langIsChanged = await appLocalDataSource.changeLang(langCode);
      return Right(langIsChanged);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await appLocalDataSource.getSavedLang();
      return Right(langCode);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg.toString()));
    }
  }
}
