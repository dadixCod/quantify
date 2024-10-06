import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_state.dart';
import 'package:quantify/shared/widgets/custom_filled_text_field.dart';
import 'package:quantify/shared/widgets/main_button.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Client',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isLight ? AppColors.mainText : AppColors.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Client Name'),
            const SizedBox(height: 15),
            CustomFilledTextField(
              width: width,
              height: height,
              isLight: isLight,
              hintText: 'Mehdi',
              controller: _nameController,
            ),
            const SizedBox(height: 15),
            const Text('Client Phone'),
            const SizedBox(height: 15),
            CustomFilledTextField(
              width: width,
              height: height,
              isLight: isLight,
              hintText: '012345678',
              controller: _phoneController,
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            const Spacer(),
            MainButton(
              onTap: () {
                if (_nameController.text.isNotEmpty ||
                    _phoneController.text.isNotEmpty ||
                    _phoneController.text.length == 10) {
                  final newClient = ClientEntity(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    visits: 0,
                    totalSpent: 0,
                    dept: 0,
                  );

                  context.read<ClientsBloc>().add(
                        AddClientEvent(
                          client: newClient,
                        ),
                      );
                  context.read<ClientsBloc>().add(GetClientsEvent());
                  context.navigator.pop();
                }
              },
              child: BlocBuilder<ClientsBloc, ClientsState>(
                  builder: (context, state) {
                if (state is ClientActionLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(AppColors.bgColor),
                    ),
                  );
                }
                return const Text(
                  'Add Client',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bgColor,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
