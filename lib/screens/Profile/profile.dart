import 'package:flutter/material.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
