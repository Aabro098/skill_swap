import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/settings_model.dart';
import 'package:skill_swap/utils/constants/enums.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  bool _isOn = false;

  List<SettingsItemModel> get settingsItems => [
        SettingsItemModel(
          title: "Dark Theme",
          icon: Iconsax.sun_14,
          type: SettingsTileType.switchTile,
          value: _isOn,
          onChanged: (val) {
            if (mounted) {
              setState(() => _isOn = val);
            }
          },
        ),
        SettingsItemModel(
          title: "Language",
          icon: Iconsax.language_circle,
          type: SettingsTileType.navigationTile,
          onTap: () {},
        ),
        SettingsItemModel(
          title: "Help & Support",
          icon: Iconsax.message_question,
          type: SettingsTileType.navigationTile,
          onTap: () {},
        ),
        SettingsItemModel(
          title: "About Us",
          icon: Iconsax.info_circle,
          type: SettingsTileType.navigationTile,
          onTap: () {},
        ),
        SettingsItemModel(
          title: "Delete Account",
          icon: Iconsax.trash,
          type: SettingsTileType.customTile,
          onTap: () {},
          color: Colors.red,
        ),
        SettingsItemModel(
          title: "Logout",
          icon: Iconsax.logout,
          type: SettingsTileType.customTile,
          onTap: () {},
          color: Colors.red,
        ),
      ];

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.black87 : Colors.grey.shade100,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(AppSizes.xl)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  "Settings",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: AppSizes.sm,
                ),
                ...settingsItems.map((item) => SettingsTile(item: item)),
              ],
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
            activeColor: Colors.green,
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
        item.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 64,
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=687&q=80"),
        ),
        const SizedBox(height: AppSizes.lg),
        AutoSizeText(
          "Arbin Shrestha",
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSizes.xs),
        AutoSizeText(
          "arbinstha71@gmail.com",
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          width: 196,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.xl),
              ),
            ),
            onPressed: () {},
            child: const Text("Upgrade Now - Go Pro"),
          ),
        ),
      ],
    );
  }
}
