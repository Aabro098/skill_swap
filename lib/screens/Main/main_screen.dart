import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/bottom_nav_bar.dart';
import 'package:skill_swap/providers/chat_provider.dart';
import 'package:skill_swap/screens/Main/Friends/friends_screen.dart';
import 'package:skill_swap/screens/Main/Matching/matching.dart';
import 'package:skill_swap/screens/Main/Messenger/messenger.dart';
import 'package:skill_swap/services/socket_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  @override
  void dispose() {
    SocketService.instance.disconnect();
    super.dispose();
  }

  Future<void> _connectSocket() async {
    try {
      await SocketService.instance.connect();
      if (mounted) {
        context.read<ChatProvider>().initializeSocketListeners();
      }
      debugPrint('✅ Socket connected and listeners initialized');
    } catch (e) {
      debugPrint('❌ Failed to connect socket: $e');
    }
  }

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
