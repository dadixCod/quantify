import 'package:quantify/core/utils/use_case.dart';
import 'package:quantify/features/onboarding/domain/repository/on_boarding_repo.dart';
import 'package:quantify/service_locator.dart';

class CheckOnboardingUsecase extends UseCase<bool, void> {
  @override
  Future<bool> call({void params}) async {
    return sl<OnBoardingRepo>().checkOnBoarding();
  }
}
