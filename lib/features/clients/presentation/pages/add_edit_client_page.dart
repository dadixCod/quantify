import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_state.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/service_locator.dart';
import 'package:quantify/shared/widgets/custom_filled_text_field.dart';
import 'package:quantify/shared/widgets/main_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEditClientPage extends StatefulWidget {
  final ClientEntity? selectedClient;
  const AddEditClientPage({super.key, this.selectedClient});

  @override
  State<AddEditClientPage> createState() => _AddEditClientPageState();
}

class _AddEditClientPageState extends State<AddEditClientPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();

    if (widget.selectedClient != null) {
      _nameController.text = widget.selectedClient!.name;
      _phoneController.text = widget.selectedClient!.phone;
    }

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
    final fromEdit = widget.selectedClient != null;
final shopId = sl<SharedPreferences>().getInt('shopId');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fromEdit ? 'Edit Client' : 'Add Client',
          style: const TextStyle(
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
                  if (widget.selectedClient != null) {
                    //Todo
                    final updatedClient = ClientEntity(
                      id: widget.selectedClient!.id,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      visits: widget.selectedClient!.visits,
                      totalSpent: widget.selectedClient!.totalSpent,
                      dept: widget.selectedClient!.dept,
                      shopId: shopId!,
                    );
                    context
                        .read<ClientsBloc>()
                        .add(UpdateClientEvent(client: updatedClient));
                  } else {
                    final newClient = ClientEntity(
                      name: _nameController.text,
                      phone: _phoneController.text,
                      visits: 0,
                      totalSpent: 0,
                      dept: 0,
                      shopId: shopId!,
                    );

                    context.read<ClientsBloc>().add(
                          AddClientEvent(
                            client: newClient,
                          ),
                        );
                  }

                  context.read<ClientsBloc>().add(GetClientsEvent());
                  context.navigator.pop();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context
                        .read<TicketsBloc>()
                        .add(GetTicketsEvent(date: DateTime.now()));
                  });
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
                return Text(
                  fromEdit ? 'Edit Client' : 'Add Client',
                  style: const TextStyle(
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
