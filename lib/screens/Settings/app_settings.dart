import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/settings_model.dart';
import 'package:skill_swap/providers/auth_provider.dart';
import 'package:skill_swap/screens/Auth/login_screen.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/language_select.dart';
import 'package:skill_swap/utils/constants/enums.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/providers/theme_provider.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  late bool _isOn;

  List<SettingsItemModel> get settingsItems => [
        SettingsItemModel(
          title: 'dark_theme',
          icon: Iconsax.sun_14,
          type: SettingsTileType.switchTile,
          value: _isOn,
          onChanged: (val) async {
            if (mounted) {
              setState(() => _isOn = val);
              await context
                  .read<ThemeProvider>()
                  .setTheme(val ? ThemeMode.dark : ThemeMode.light);
            }
          },
        ),
        SettingsItemModel(
          title: 'language',
          icon: Iconsax.language_circle,
          type: SettingsTileType.navigationTile,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LanguageSelector(
                  onDone: (ctx) {
                    Navigator.pop(ctx);
                  },
                ),
              ),
            );
          },
        ),
        SettingsItemModel(
          title: 'help_support',
          icon: Iconsax.message_question,
          type: SettingsTileType.navigationTile,
          onTap: () {},
        ),
        SettingsItemModel(
          title: 'about_us',
          icon: Iconsax.info_circle,
          type: SettingsTileType.navigationTile,
          onTap: () {},
        ),
        SettingsItemModel(
          title: 'delete_account',
          icon: Iconsax.trash,
          type: SettingsTileType.customTile,
          onTap: () {},
          color: Colors.red,
        ),
        SettingsItemModel(
          title: 'logout',
          icon: Iconsax.logout,
          type: SettingsTileType.customTile,
          onTap: () async {
            await context.read<AuthProvider>().logout();
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              LoginScreen.routeName,
              (Route<dynamic> route) => false,
            );
          },
          color: Colors.red,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    _isOn = context.read<ThemeProvider>().themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SettingsHeader(),
            ),
            // const SizedBox(height: AppSizes.md),
            // SizedBox(
            //   width: 196,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(AppSizes.xl),
            //       ),
            //     ),
            //     onPressed: () {},
            //     child: Text(context.tr('upgrade_account')),
            //   ),
            // ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          width: double.infinity,
          // height: context.screenHeight * 0.5,
          padding: const EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.black87 : Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(36),
                offset: const Offset(0, -4),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSizes.xl)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      AutoSizeText(
                        context.tr('settings'),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Icon(Icons.arrow_drop_up, color: Colors.grey.shade400),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.sm,
                  ),
                  ...settingsItems.map((item) => SettingsTile(item: item)),
                  const SizedBox(
                    height: AppSizes.md,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, required this.item});

  final SettingsItemModel item;

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;

    switch (item.type) {
      case SettingsTileType.switchTile:
        trailingWidget = Transform.scale(
          scale: 0.75,
          child: Switch(
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            activeThumbColor: Colors.green,
            activeTrackColor: Colors.green.shade100,
            inactiveTrackColor: Colors.red.shade100,
            inactiveThumbColor: Colors.red,
            value: item.value ?? false,
            onChanged: item.onChanged,
          ),
        );
        break;

      case SettingsTileType.navigationTile:
        trailingWidget = const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        );
        break;

      case SettingsTileType.customTile:
        trailingWidget = item.trailing;
        break;
    }

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: item.onTap,
      leading: Icon(
        item.icon,
        color: item.color,
      ),
      title: Text(
        context.tr(item.title),
        style: context.textTheme.titleMedium?.copyWith(
          color: item.color,
        ),
      ),
      trailing: trailingWidget,
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 64,
            backgroundImage: const AssetImage(AppImages.fallback),
            foregroundImage: NetworkImage(provider.user?.profileUrl ?? ''),
            onForegroundImageError: (_, __) {},
          ),
          const SizedBox(height: AppSizes.lg),
          AutoSizeText(
            provider.user?.name ?? '',
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.xs),
          AutoSizeText(
            provider.user?.email ?? '',
            style: context.textTheme.titleSmall,
          ),
        ],
      );
    });
  }
}
