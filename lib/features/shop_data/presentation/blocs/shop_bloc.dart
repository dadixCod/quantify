import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/shop_data/domain/usecase/add_shop_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/get_shop_byemail_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/get_shop_data_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/login_shop_usecase.dart';
import 'package:quantify/features/shop_data/domain/usecase/update_shop_usecase.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';
import 'package:quantify/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<GetShopDataById>((event, emit) async {
      emit(ShopLoading());
      try {
        final shopId = sl<SharedPreferences>().getInt('shopId');
        if (shopId != null) {
          final shop = await sl<GetShopDataByIdUsecase>().call(params: shopId);
          emit(ShopLoaded(shop: shop));
        } else {
          emit(ShopNull());
        }
      } catch (e) {
        log(e.toString());
        emit(ShopNull());
      }
    });
    on<GetShopDataByEmail>((event, emit) async {
      emit(ShopLoading());
      try {
        final shop =
            await sl<GetShopDataByEmailUseCase>().call(params: event.email);
        if (shop.id != null) {
          await sl<SharedPreferences>().setInt('shopId', shop.id!);
          log(sl<SharedPreferences>().getInt('shopId').toString());
          emit(ShopLoaded(shop: shop));
        }
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
          add(GetShopDataByEmail(email: event.shop.email));
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
          add(GetShopDataById());
        } catch (e) {
          emit(ShopError(message: e.toString()));
        }
      },
    );
    on<LoginShop>((event, emit) async {
      emit(ShopLoading());
      try {
        await sl<LoginShopUsecase>().call(params: event.loginParams);
        add(GetShopDataByEmail(email: event.loginParams.email));
      } catch (e) {
        emit(ShopError(message: e.toString()));
      }
    });
    on<LogoutFromShop>((event, emit) async {
      emit(ShopLoading());
      try {
        await sl<SharedPreferences>().remove('shopId');
        emit(ShopLoggedOut());
      } catch (e) {
        emit(ShopError(message: e.toString()));
      }
    });
  }
}
