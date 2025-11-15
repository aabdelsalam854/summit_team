import 'package:summit_team/features/app/domain/repositories/app_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:summit_team/core/error/failures.dart';
import 'package:summit_team/core/usecases/usecase.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetSavedLangUseCase({required this.appRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await appRepository.getSavedLang();
}
