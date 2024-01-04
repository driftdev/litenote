import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notelite/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isDarkMode ? "Light Mode ☀️" : "Dark Mode 🌙",
            ),

            Switch(
              value: isDarkMode,
              onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              activeColor: isDarkMode ? Colors.white : Colors.black,
            )
          ]
        ),
      ),
    );
  }
}