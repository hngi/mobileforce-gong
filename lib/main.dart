import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:team_mobileforce_gong/state/theme_notifier.dart';

import 'UI/screens/splashscreen.dart';
import 'state/authProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff0984E3),
  ));
  
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      child: MyApp(),
      create: (BuildContext context) {
        return ThemeNotifier();
      },
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeNotifier>(context).loadThemeData(context);
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthenticationState()),
          ],
            child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gong',
            theme: Provider.of<ThemeNotifier>(context).currentThemeData,
            home: SplashScreen()
          ),
        );
      },
    );
  }
}


