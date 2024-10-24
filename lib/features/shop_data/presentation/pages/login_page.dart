import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';
import 'package:quantify/shared/widgets/custom_text_field.dart';
import 'package:quantify/shared/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    final isLight = context.brightness == Brightness.light;
    return Scaffold(
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
                  delay: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    context.brightness == Brightness.light
                        ? AppVectors.topBubble
                        : AppVectors.topBubbleDark,
                  ),
                ),
              ),
              Positioned(
                bottom: -height / 7,
                right: -width / 4,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    context.brightness == Brightness.light
                        ? AppVectors.topBubble
                        : AppVectors.topBubbleDark,
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
                  child: BlocBuilder<ShopBloc, ShopState>(
                      builder: (context, state) {
                    if (state is ShopError) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          errorMessage = state.message;
                        });
                      });
                    }
                    if (state is ShopLoaded) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        context
                            .read<TicketsBloc>()
                            .add(GetTicketsEvent(date: DateTime.now()));
                        context.read<ClientsBloc>().add(GetClientsEvent());
                        context.navigator
                            .pushReplacementNamed(AppRouter.mainPage);
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Again",
                                style: context.textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomTextField(
                          hint: 'mehdi@example.com',
                          controller: _emailController,
                          icon: const Icon(Icons.email),
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomTextField(
                          hint: 'pass1234',
                          controller: _passwordController,
                          obscure: true,
                          icon: const Icon(Icons.password),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: isLight
                                ? AppColors.deleteColor
                                : AppColors.deleteDarkColor,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.26,
                        ),
                        MainButton(
                          onTap: () {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              setState(() {
                                errorMessage = '';
                              });
                              context.read<ShopBloc>().add(LoginShop(
                                  loginParams: LoginParams(
                                      email: _emailController.text,
                                      password: _passwordController.text)));
                            } else {
                              setState(() {
                                errorMessage = 'Please fill all credentials';
                              });
                            }
                          },
                          child: state is ShopLoading
                              ? const CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.bgColor),
                                )
                              : const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "You don't have an account? ",
                              style: TextStyle(fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.navigator.pushReplacementNamed(
                                    AppRouter.shopDataPage);
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
