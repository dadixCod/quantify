import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/onboarding/domain/repository/on_boarding_repo.dart';
import 'package:quantify/service_locator.dart';

class ChangeOnboardingStatusUsecase extends UseCase<void, void> {
  @override
  Future<void> call({void params}) async {
    return await sl<OnBoardingRepo>().changeOnBoardingStatus();
  }
}
