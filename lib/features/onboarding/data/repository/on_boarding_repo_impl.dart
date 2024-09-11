import 'package:quantify/features/onboarding/domain/repository/on_boarding_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingRepoImpl extends OnBoardingRepo {
  final SharedPreferences prefs;

  OnBoardingRepoImpl(this.prefs);
  @override
  Future<void> changeOnBoardingStatus() async {
    await prefs.setBool('on_boarding', true);
  }

  @override
  Future<bool> checkOnBoarding() async {
    final isOnBoardingDone = prefs.getBool('on_boarding');
    if (isOnBoardingDone != null && isOnBoardingDone == true) {
      return true;
    } else {
      return false;
    }
  }
}
