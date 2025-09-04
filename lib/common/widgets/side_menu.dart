import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/side_bar_model.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
    required this.currentItem,
    required this.onSelectedItem,
  });

  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var item in MenuItem.all) ...[
              buildMenuItem(item),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) {
    bool selected = widget.currentItem == item;
    return ListTile(
      selected: selected,
      leading: Icon(
        item.icon,
        color: selected ? Colors.yellow.shade800 : Colors.white,
      ),
      title: AutoSizeText(
        context.tr(item.title),
        maxLines: 1,
        style: context.textTheme.titleMedium?.copyWith(
          color: selected ? Colors.yellow.shade800 : Colors.white,
        ),
      ),
      onTap: () => widget.onSelectedItem(item),
    );
  }
}
