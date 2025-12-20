import 'package:banking_app/core/helper_functions/on_generate_routes.dart';
import 'package:banking_app/core/services/custom_bloc_observer.dart';
import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/core/services/shared_preference_singletone.dart';
import 'package:banking_app/core/widgets/main_layout.dart';
import 'package:banking_app/feature/auth/presentation/views/login_view.dart';
import 'package:banking_app/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(
  //   NotificationService.firebaseMessaginhBackgroundHandler,
  // );

  // await NotificationService.initializeNotification();
  setupLocator();
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();
  runApp(
    ScreenUtilInit(
      designSize: const Size(1440, 1184),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BankingApp(),
    ),
  );
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'cairo',
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: onGenerateRoutes,
      initialRoute: LoginView.routeName,
    );
  }
}
