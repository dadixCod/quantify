import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/onboarding/domain/usecase/change_onboarding_status_usecase.dart';
import 'package:quantify/features/onboarding/domain/usecase/check_onboarding_usecase.dart';
import 'package:quantify/service_locator.dart';

class OnBoardingCubit extends Cubit<bool> {
  OnBoardingCubit() : super(false);

  void changeOnBoardingStatus() async {
    await sl<ChangeOnboardingStatusUsecase>().call();
    emit(true);
  }

  void checkOnBoardingStatus() async {
    final response = await sl<CheckOnboardingUsecase>().call();
    log(response.toString());
    emit(response);
  }
}
