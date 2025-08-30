import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/common/widgets/custom_drawer.dart';
import 'package:flutter_boilerplate_mts/common/widgets/language_selector.dart';
import 'package:flutter_boilerplate_mts/extensions/context_extensions.dart';
import 'package:flutter_boilerplate_mts/utils/constants/sizes.dart';
import 'package:flutter_boilerplate_mts/utils/device/device_utility.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/helper_functions.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/notification_service.dart';
import 'package:flutter_boilerplate_mts/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  ///
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('title')),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.tr('welcomeMessage')),
              const SizedBox(height: AppSizes.md),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 12,
                spacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () => showSuccessSnackbar('Success Message'),
                    child: const Text('Success SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () => showErrorSnackbar('Error Message'),
                    child: const Text('Error SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () => showInfoSnackbar('Info Message'),
                    child: const Text('Info SnackBar'),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              ElevatedButton(
                onPressed: () {
                  NotificationService().showNotification(
                    title: 'example_notification',
                    body: 'notification_body',
                  );
                },
                child: const Text('Show Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
