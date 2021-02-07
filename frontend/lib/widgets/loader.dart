import 'package:flutter/material.dart';
import 'package:frontend/app_theme.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
