import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';
import 'package:quantify/shared/thememode/theme_cubit.dart';
import 'package:quantify/shared/widgets/custom_text_field.dart';
import 'package:quantify/shared/widgets/main_button.dart';
import 'package:quantify/shared/widgets/validation_check.dart';

class ShopDataPage extends StatefulWidget {
  const ShopDataPage({super.key});

  @override
  State<ShopDataPage> createState() => _ShopDataPageState();
}

class _ShopDataPageState extends State<ShopDataPage> {
  late PageController _pageController;
  late TextEditingController _shopNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _shopNameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _shopNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double _lowerValue = 9;
  double _upperValue = 21;
  int currentPage = 0;
  bool nameValidator = false;
  bool isValidPhone = false;
  bool isStartingNotNull = false;
  String phoneCode = "";
  String phoneNumber = "";
  bool isLoading = false;

  void loadingHandler() {
    setState(() {
      isLoading = true;
    });
  }

  void navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  String _formatTime(int hour) {
    return '${hour.toString().padLeft(2, '0')}:00';
  }

  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
     
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                top: -height / 7,
                left: -width / 4,
                child: FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    context.brightness == Brightness.light
                        ? AppVectors.topBubble
                        : AppVectors.topBubbleDark,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().updateTheme(
                          context.brightness == Brightness.light
                              ? ThemeMode.dark
                              : ThemeMode.light,
                        );
                  },
                  icon: SvgPicture.asset(
                    context.brightness == Brightness.light
                        ? AppVectors.moonStars
                        : AppVectors.sun,
                    colorFilter: ColorFilter.mode(
                      context.brightness == Brightness.light
                          ? AppColors.darkBgColor
                          : AppColors.fadeColor,
                      BlendMode.srcIn,
                    ),
                    height: 25,
                  ),
                ),
              ),
              Positioned(
                bottom: height / 5,
                right: -width / 3.8,
                child: FadeInRight(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: SvgPicture.asset(
                    AppVectors.bottomBubble,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.17,
                  left: 35,
                  right: 35,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: Text(
                          "Let’s get to know you",
                          style: context.textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 9,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 8);
                            },
                            itemBuilder: (context, index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: width / 5.18,
                                decoration: BoxDecoration(
                                  color: currentPage == index
                                      ? AppColors.maincolor
                                      : AppColors.inactiveItem,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: height / 2,
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (newIndex) {
                            setState(() {
                              currentPage = newIndex;
                            });
                          },
                          children: [
                            _buildShopName(),
                            _buildAddresse(),
                            _buildPhoneNum(context, width),
                            _buildWorkingHours(),
                          ],
                        ),
                      ),
                      MainButton(
                        child: BlocBuilder<ShopBloc, ShopState>(
                            builder: (context, state) {
                          if (state is ShopLoading) {
                            return const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ShopError) {
                            SchedulerBinding.instance.addPostFrameCallback(
                              (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      state.message,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is ShopAdded) {
                            SchedulerBinding.instance.addPostFrameCallback(
                              (_) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/main');
                              },
                            );
                          }
                          return Text(
                            currentPage == 3 ? 'Validate' : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }),
                        onTap: () {
                          if (currentPage == 0 && nameValidator == true) {
                            navigateToPage(1);
                          } else if (currentPage == 1) {
                            navigateToPage(2);
                          } else if (currentPage == 2 &&
                              isStartingNotNull == true &&
                              isValidPhone == true) {
                            log(phoneNumber);
                            navigateToPage(3);
                          } else if (currentPage == 3) {
                            final shop = ShopEntity(
                              shopName: _shopNameController.text,
                              phoneNumber: phoneNumber,
                              address: _addressController.text.isNotEmpty
                                  ? _addressController.text
                                  : '',
                              startHour: _formatTime(_upperValue.toInt()),
                              endHour: _formatTime(_lowerValue.toInt()),
                            );
                            context.read<ShopBloc>().add(AddShop(shop: shop));
                          }
                        },
                      ),
                      if (currentPage > 0)
                        TextButton(
                          onPressed: () {
                            navigateToPage(currentPage - 1);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildShopName() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shop Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomTextField(
            hint: 'Name',
            icon: SvgPicture.asset(
              AppVectors.store,
            ),
            controller: _shopNameController,
            onChanged: (value) {
              if (value.length >= 6) {
                setState(() {
                  nameValidator = true;
                });
              } else {
                setState(() {
                  nameValidator = false;
                });
              }
            },
          ),
          // const SizedBox(height: 20),
          ValidationCheck(
            isChecked: nameValidator,
            text: "At least 6 caracters",
          )
        ],
      ),
    );
  }

  Container _buildAddresse() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomTextField(
            hint: '123 Street (Optional)',
            icon: SvgPicture.asset(
              AppVectors.mapPin,
            ),
            controller: _addressController,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container _buildPhoneNum(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Number',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                height: 58,
                width: 120,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(
                    color: context.brightness == Brightness.dark
                        ? AppColors.borderDarkColor
                        : AppColors.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CountryCodePicker(
                  initialSelection: 'DZ',
                  onInit: (value) {
                    phoneCode = value!.dialCode!;
                  },
                  onChanged: (value) {
                    phoneCode = value.dialCode!;
                  },
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: width * 0.45,
                child: CustomTextField(
                  hint: '123456789',
                  keyboardType: TextInputType.number,
                  icon: SvgPicture.asset(
                    AppVectors.phone,
                  ),
                  controller: _phoneController,
                  onChanged: (value) {
                    phoneNumber = "$phoneCode$value";
                    if (!value.startsWith("0")) {
                      setState(() {
                        isStartingNotNull = true;
                      });
                      if (value.length >= 9 && value.length < 12) {
                        setState(() {
                          isValidPhone = true;
                        });
                      } else {
                        setState(() {
                          isValidPhone = false;
                        });
                      }
                    } else {
                      setState(() {
                        isStartingNotNull = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),
          ValidationCheck(
            isChecked: isStartingNotNull,
            text: "Phone should not start with 0",
          ),
          const SizedBox(height: 10),
          ValidationCheck(
            isChecked: isValidPhone,
            text: "Enter correct length",
          ),
        ],
      ),
    );
  }

  Container _buildWorkingHours() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Working Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 28),

          FlutterSlider(
            values: [_lowerValue, _upperValue],
            rangeSlider: true,
            max: 24,
            min: 0,
            minimumDistance: 1,
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 11,
              inactiveTrackBarHeight: 11,
              activeTrackBar: BoxDecoration(
                color: AppColors.maincolor,
                borderRadius: BorderRadius.circular(999),
              ),
              inactiveTrackBar: BoxDecoration(
                color: AppColors.inactiveItem,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            handler: FlutterSliderHandler(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              child: Container(
                height: 28,
                width: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.maincolor,
                ),
              ),
            ),
            rightHandler: FlutterSliderHandler(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              child: Container(
                height: 28,
                width: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.maincolor,
                ),
              ),
            ),
            tooltip: FlutterSliderTooltip(
              boxStyle: const FlutterSliderTooltipBox(),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              format: (String value) {
                return _formatTime(double.parse(value).toInt());
              },
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                _lowerValue = lowerValue;
                _upperValue = upperValue;
              });
            },
          ),
          // Display the current time values
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(_lowerValue.toInt()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _formatTime(_upperValue.toInt()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}