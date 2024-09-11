import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/onboarding/data/sources/onboarding_list.dart';
import 'package:quantify/features/onboarding/presentation/blocs/on_boarding_cubit.dart';
import 'package:quantify/shared/widgets/main_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  bool isLoading = false;

  Widget animateDo(int index, int delay, Widget child) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    final brightness = context.brightness;
    return Scaffold(
    
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: pageController,
                itemCount: onBoardingList.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });
                },
                itemBuilder: (context, index) {
                  final item = onBoardingList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      animateDo(
                        index,
                        100,
                        SizedBox(
                          height: height * 0.25,
                          width: width,
                          child: SvgPicture.asset(
                            brightness == Brightness.light
                                ? item.image
                                : item.darkImage,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      animateDo(
                        index,
                        300,
                        Text(
                          item.title,
                          style: context.textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                      animateDo(
                        index,
                        500,
                        Text(
                          item.subtitle,
                          style: context.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 35),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: onBoardingList.length,
                      effect: const ExpandingDotsEffect(
                        spacing: 6.0,
                        radius: 10.0,
                        dotWidth: 15.0,
                        dotHeight: 6.0,
                        expansionFactor: 3.0,
                        dotColor: AppColors.inactiveItem,
                        activeDotColor: AppColors.maincolor,
                      ),
                      onDotClicked: (newIndex) {
                        setState(() {
                          currentPage = newIndex;
                          pageController.animateToPage(
                            newIndex,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: MainButton(
                      onTap: () {
                        setState(() {
                          if (currentPage == 2) {
                            setState(() {
                              isLoading = true;
                              Future.delayed(const Duration(seconds: 2))
                                  .then((value) {
                                isLoading = false;
                                context
                                    .read<OnBoardingCubit>()
                                    .changeOnBoardingStatus();

                                Navigator.of(context)
                                    .pushReplacementNamed('/shop_data');
                              });
                            });
                          } else {
                            pageController.animateToPage(
                              ++currentPage,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn,
                            );
                          }
                        });
                      },
                      child: isLoading
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              currentPage == 2 ? 'Continue' : 'Next',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  if (currentPage < 2)
                    TextButton(
                      onPressed: () {
                        pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
