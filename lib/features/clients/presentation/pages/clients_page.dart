import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_state.dart';
import 'package:quantify/features/clients/presentation/widgets/client_card.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> refresh() async {
    context.read<ClientsBloc>().add(GetClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    final isLight = context.brightness == Brightness.light;

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            context.navigator.pushNamed(AppRouter.addEditClientPage);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.maincolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
          child: const Text(
            'Add Client',
            style: TextStyle(
              color: AppColors.bgColor,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                //Top container
                Container(
                  height: height * 0.25,
                  width: width,
                  padding: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    color: AppColors.maincolor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.42,
                          ),
                          const Text(
                            'Clients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bgColor,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.26,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              AppVectors.funnel,
                              height: 12,
                              width: 12,
                              colorFilter: const ColorFilter.mode(
                                AppColors.bgColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: width,
                          height: height * 0.06,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: isLight
                                ? AppColors.bgColor.withOpacity(0.8)
                                : AppColors.darkBgColor.withOpacity(0.8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: isLight
                                    ? AppColors.maincolor
                                    : AppColors.bgColor.withAlpha(150),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: width * 0.7,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (searchField) {
                                    if (searchField.isNotEmpty) {
                                      context.read<ClientsBloc>().add(
                                          SearchClientsEvent(
                                              text: searchField));
                                    } else {
                                      context
                                          .read<ClientsBloc>()
                                          .add(GetClientsEvent());
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 8),
                                    border: InputBorder.none,
                                    hintText: 'Search for clients',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                    ),
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
                //Clients
                const SizedBox(height: 20),
                Container(
                  height: height * 0.7,
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: BlocBuilder<ClientsBloc, ClientsState>(
                      builder: (context, state) {
                    if (state is ClientsLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.maincolor),
                        ),
                      );
                    } else if (state is ClientsError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is ClientsLoaded) {
                      if (state.clients.isEmpty) {
                        return Center(
                          child: SizedBox(
                            height: height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset(
                                  AppVectors.noTickets,
                                  height: height * 0.3,
                                ),
                                const Text('NO CLIENTS YET'),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.clients.length,
                          itemBuilder: (context, index) {
                            final client = state.clients[index];
                            return ClientCard(
                              height: height,
                              isLight: isLight,
                              client: client,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 5);
                          },
                        );
                      }
                    }
                    return const SizedBox();
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
