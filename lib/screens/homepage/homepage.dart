import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/bottom_nav_bar.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/utils/providers/theme.provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
        Scaffold(
          appBar: null,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple.shade300,
                  Colors.purple,
                  Colors.black,
                ],
                stops: const [0.0, 0.2, 1.0],
              ),
            ),
            child: const Center(
              child: Text("Messages"),
            ),
          ),
        ),
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
