import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:skill_swap/common/widgets/side_menu.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/side_bar_model.dart';
import 'package:skill_swap/screens/ChatBot/chatbot.dart';
import 'package:skill_swap/screens/Main/main_screen.dart';
import 'package:skill_swap/screens/Profile/profile.dart';
import 'package:skill_swap/screens/Settings/app_settings.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  MenuItem currentItem = MenuItem.home;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple,
            context.isDarkMode ? Colors.black : Colors.white,
          ],
          stops: const [0.0, 0.8],
        ),
      ),
      child: ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        borderRadius: 42,
        angle: -10,
        slideHeight: MediaQuery.of(context).size.height * 0.2,
        slideWidth: 272,
        showShadow: true,
        shadowLayer2Color: Colors.lime.shade300,
        menuBackgroundColor: Colors.transparent,
        menuScreen: Builder(
          builder: (context) => SideMenu(
            currentItem: currentItem,
            onSelectedItem: (item) {
              if (mounted) setState(() => currentItem = item);
              ZoomDrawer.of(context)!.close();
            },
          ),
        ),
        mainScreen: getScreen(),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItem.home:
        return const MainScreen();
      case MenuItem.chatbot:
        return const Chatbot();
      case MenuItem.profile:
        return const Profile();
      case MenuItem.settings:
        return const AppSettings();
      default:
        return const MainScreen();
    }
  }
}
