import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/common/widgets/bottom_nav_bar.dart';
import 'package:skill_swap/screens/Main/Friends/friends_screen.dart';
import 'package:skill_swap/screens/Main/Matching/matching.dart';
import 'package:skill_swap/screens/Main/Messenger/messenger.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
        const MessengerScreen(),
        const FindMatch(),
        const FriendsScreen(),
      ];

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
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
