import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:quantify/core/configs/app_router.dart';

import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/dashboard/presentation/widgets/client_ticket_card.dart';
import 'package:quantify/features/dashboard/presentation/widgets/ticket_container.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final today = DateFormat.MMMEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final width = context.deviceSize.width;
    final height = context.deviceSize.height;
    bool isLight = context.brightness == Brightness.light;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      floatingActionButton: InkWell(
        onTap: () {
          context.navigator.pushNamed(AppRouter.addTicketScreen);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.maincolor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppVectors.pencil,
              ),
              const SizedBox(width: 6),
              const Text(
                'Add Ticket',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoaded) {
            final shopName = state.shop.shopName.split(" ");
            final firstName = shopName[0];
            return SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Container(
                    height: height / 3.8,
                    width: width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.maincolor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width / 3.5),
                          child: Column(
                            children: [
                              Text(
                                "Hello, $firstName",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                today,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            //TODO Notifiaction
                          },
                          icon: SvgPicture.asset(
                            AppVectors.bell,
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height - height / 4.4,
                      width: width,
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        140,
                        20,
                        10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        color:
                            isLight ? AppColors.bgColor : AppColors.darkBgColor,
                      ),
                      child: Column(
                        children: [
                          TabBar(
                            padding: const EdgeInsets.only(bottom: 20),
                            controller: _tabController,
                            indicatorColor: AppColors.tertiaryText,
                            indicatorPadding:
                                const EdgeInsets.symmetric(vertical: -10),
                            labelColor:
                                isLight ? AppColors.maincolor : Colors.white,
                            unselectedLabelColor: isLight
                                ? Colors.black.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            tabs: const [
                              Text(
                                'Clients',
                              ),
                              Text(
                                'Done',
                              ),
                            ],
                          ),

                          SizedBox(
                            height: height * 0.53,
                            child: TabBarView(
                                controller: _tabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 14,
                                      );
                                    },
                                    itemCount: 7,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return ClientTicketCard(
                                        width: width,
                                        isLight: isLight,
                                        index: index,
                                      );
                                    },
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    child: Text('2'),
                                  ),
                                ]),
                          )
                          // TabBarView(children: children)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 20,
                    right: 20,
                    child: TicketWidget(
                      height: height,
                      isLight: isLight,
                      width: width,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
