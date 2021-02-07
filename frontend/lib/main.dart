import 'package:flutter/material.dart';
import 'package:frontend/provider/meme_provider.dart';
import 'package:frontend/utils/global.dart';
import 'package:frontend/view/meme_screen.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MemeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Global.appName,
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.accentColor,
        ),
        home: MemeScreen(),
      ),
    );
  }
}
