import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/bottom_nav_bar.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/screens/Main/messenger.dart';
import 'package:skill_swap/utils/providers/theme.provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
        const MessengerScreen(),
        Scaffold(
            appBar: AppBar(
              title: const AutoSizeText("Skill Swap"),
              leading: const MenuWidget(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.color_lens),
                  onPressed: () {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                ),
              ],
            ),
            body: const Center(child: Text("Search"))),
        const Scaffold(body: Center(child: Text("Contacts"))),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
}
