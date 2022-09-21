import 'package:api/component/component/component.dart';
import 'package:api/layout/news_app/cubit/cubit.dart';
import 'package:api/layout/news_app/cubit/states.dart';
import 'package:api/layout/shop_app/cubit/cubit.dart';
import 'package:api/layout/zone_app/cubit/zone_cubit.dart';
import 'package:api/layout/zone_app/zone_app_layout.dart';
import 'package:api/modules/shop_app/login/cubit/cubit.dart';
import 'package:api/modules/zone_app/zone_login/zone_login_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:api/network/remote/dio_helper.dart';
import 'package:api/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage)async{
print(remoteMessage.data.toString());
showToast(msg: 'BackGround', state: ToastState.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DioHelper.init();
  await CashedHelper.init();
  bool isDark = CashedHelper.getData("isDark");
  Widget widget;
  // bool onBoarding = CashedHelper.getData("onBoarding");
  // token = CashedHelper.getData("token");
  uId = CashedHelper.getData("uId");
  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else {
  //   widget = OnBoardingScreen();
  // }
  if(uId !=null){
    widget = const ZoneLayout();
  }else{
    widget=ZoneLoginScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool onBoarding;
  final Widget startWidget;

   MyApp({this.isDark, this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData()
            ..getCartData(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getScience()
            ..getSports()
            ..getBusiness(),
        ),
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..changeAppMode(fromShared: isDark)),
        BlocProvider(
            create: (context) => ZoneCubit()
              ..getUserData()..getPosts()..getComments()..getAllUsers())
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // print("${NewsCubit.get(context).isDark}");
          return MaterialApp(
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode:ThemeMode.dark,
            // NewsCubit.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            title: "API",
            home:
            // AnimatedSplashScreen(
            //   duration: 3000,
            //   splash: "assets/images/10.png",
            //   nextScreen: startWidget,
            //   splashTransition: SplashTransition.fadeTransition,
            //   pageTransitionType: PageTransitionType.fade,
            //   splashIconSize: 300,
            // ),
              startWidget,
            // Directionality(
            //     textDirection: TextDirection.ltr, child: NewsLayout()),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("API"),
        ),
        body: Center(
          child: Container(
            child: const Text("API"),
          ),
        ),
      ),
    );
  }
}
