import 'package:barbershop2/classes/Estabelecimento.dart';
import 'package:barbershop2/firebase_options.dart';
import 'package:barbershop2/functions/CorteProvider.dart';
import 'package:barbershop2/functions/createAccount.dart';
import 'package:barbershop2/functions/managerScreenFunctions.dart';
import 'package:barbershop2/functions/profileScreenFunctions.dart';
import 'package:barbershop2/functions/providerFilterStrings.dart';
import 'package:barbershop2/functions/rankingProviderHome.dart';
import 'package:barbershop2/functions/userLogin.dart';
import 'package:barbershop2/rotas/Approutes.dart';
import 'package:barbershop2/screen/add/confirmscreen/ConfirmScreenCorte.dart';
import 'package:barbershop2/screen/home/homeScreen01.dart';
import 'package:barbershop2/screen/inicio/initialScreen.dart';
import 'package:barbershop2/screen/login/loginScreen.dart';
import 'package:barbershop2/screen/manager/ManagerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/login/registerAccount.dart';
import 'rotas/verificationLogin.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Chame primeiro aqui ele inicia os widgets
  //so apos dar o start, ele inicia o firebase, aqui o app ja esta carregado e funcionando
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyProfileScreenFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateAccount(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserLoginApp(),
        ),
        ChangeNotifierProvider(
          create: (_) => CorteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RankingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManagerScreenFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderFilterManager(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            cancelButtonStyle: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            confirmButtonStyle: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: Estabelecimento.nomeLocal,
        routes: {
          AppRoutesApp.VerificationLoginScreen01: (ctx) =>
              const VerificationLoginScreen01(),
          AppRoutesApp.InitialScreenApp: (ctx) => const InitialScreenApp(),
          AppRoutesApp.LoginScreen01: (ctx) => const LoginScreen01(),
          AppRoutesApp.HomeScreen01: (ctx) => const HomeScreen01(),
          AppRoutesApp.RegisterAccountScreen: (ctx) =>
              const RegisterAccountScreen(),
          AppRoutesApp.ConfirmScreenCorte: (ctx) => ConfirmScreenCorte(),
          AppRoutesApp.ManagerScreenView: (ctx) => ManagerScreenView(),
        },
      ),
    );
  }
}
