import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/custom_drawer.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';
import 'package:skill_swap/utils/helpers/notification_service.dart';
import 'package:skill_swap/utils/providers/theme.provider.dart';

class MyHomePage extends StatefulWidget {
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
                    onPressed: () =>
                        showInfoSnackbar('Info Message', context: context),
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
