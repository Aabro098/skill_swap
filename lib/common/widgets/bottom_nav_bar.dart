import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
