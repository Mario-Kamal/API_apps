import 'package:api/layout/shop_app/cubit/states.dart';
import 'package:api/models/shop_app/cart_model.dart';
import 'package:api/models/shop_app/categories_model.dart';
import 'package:api/models/shop_app/change_favorites_model.dart';
import 'package:api/models/shop_app/home_model.dart';
import 'package:api/models/shop_app/login_model.dart';
import 'package:api/modules/shop_app/categories/categories_screen.dart';
import 'package:api/modules/shop_app/favorite/favorite_screen.dart';
import 'package:api/modules/shop_app/products/products_screen.dart';
import 'package:api/modules/shop_app/search/search_screen.dart';
import 'package:api/modules/shop_app/settings/settings_screen.dart';
import 'package:api/network/end_points.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  String token = CashedHelper.getData("token");

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopBottomNavBarState());
  }

  List<Widget> bottomItems = [
    Icon(Icons.home),
    Icon(Icons.category),
    Icon(Icons.favorite),
    Icon(Icons.settings),
  ];
  HomeModel homeModel;
  Map<int, bool> favourites = {};
  Map<int, bool> cart = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorite});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: Categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  changeFavourites(int productId) {
    favourites[productId] = !favourites[productId];
    emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    DioHelper.postData(
      url: Favourites,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        favourites[productId] = !favourites[productId];
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavouriteModel favouriteModel;

  void getFavoritesData() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(url: Favourites, token: token).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      emit(ShopErrorFavoritesDataState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
      @required String name,
      @required String email,
      @required String phone,
      ) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UpdateProfile,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }
  ChangeCartModel changeCartModel;

  changeCart(int productId) {
    cart[productId] = !cart[productId];
    emit(ShopSuccessChangeCartState(changeCartModel));
    DioHelper.postData(
      url: Cart,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      print(value.data);
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if (!changeCartModel.status) {
        cart[productId] = !cart[productId];
      } else {
        getCartData();
      }
      emit(ShopSuccessChangeCartState(changeCartModel));
    }).catchError((error) {
      emit(ShopErrorChangeCartState());
    });
  }

  CartModel cartModel;

  void getCartData() {
    emit(ShopLoadingCartDataState());
    DioHelper.getData(url: Cart, token: token).then((value) {
      print(value.data);
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessCartDataState());
    }).catchError((error) {
      emit(ShopErrorCartDataState());
    });
  }
}

