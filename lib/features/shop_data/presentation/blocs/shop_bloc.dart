import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/shop_data/domain/usecase/add_shop_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/get_shop_data_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/update_shop_usecase.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';
import 'package:quantify/service_locator.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<GetShopData>((event, emit) async {
      emit(ShopLoading());
      try {
        final shop = await sl<GetShopDataUsecase>().call();
        emit(ShopLoaded(shop: shop));
      } catch (e) {
        log(e.toString());
        emit(ShopNull());
      }
    });

    on<AddShop>(
      (event, emit) async {
        emit(ShopLoading());
        try {
          final response = await sl<AddShopUsecase>().call(params: event.shop);
          log(response.toString());
          emit(ShopAdded());
          add(GetShopData());
        } catch (e) {
          emit(ShopError(message: e.toString()));
        }
      },
    );
    on<UpdateShop>(
      (event, emit) async {
        emit(ShopLoading());
        try {
          final response =
              await sl<UpdateShopUsecase>().call(params: event.shop);
          log(response.toString());
          emit(ShopUpdated());
          add(GetShopData());
        } catch (e) {
          emit(ShopError(message: e.toString()));
        }
      },
    );
  }
}
