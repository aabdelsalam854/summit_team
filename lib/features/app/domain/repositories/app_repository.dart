import 'package:dartz/dartz.dart';
import 'package:summit_team/core/error/failures.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> getSavedLang();
  Future<Either<Failure, bool>> changeLang(String langCode);
}
