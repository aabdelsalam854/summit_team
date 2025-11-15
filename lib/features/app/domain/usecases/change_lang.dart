import 'package:summit_team/features/app/domain/repositories/app_repository.dart';
import 'package:summit_team/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:summit_team/core/error/failures.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final AppRepository appRepository;

  ChangeLangUseCase({required this.appRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await appRepository.changeLang(langCode);
}
