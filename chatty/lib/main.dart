import 'package:chatty/providers/app_provider.dart';
import 'package:chatty/providers/service_provider.dart';
import 'package:chatty/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(
      create: (context) => SocketService(),
    ),
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
  
    )
    ],
      child: const MyApp()  
    
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: Provider.of<AppProvider>(context).isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      );
  }
}
