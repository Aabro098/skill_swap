import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/screens/Main/Messenger/messenger.dart';

class MessengerAppbar extends StatefulWidget {
  const MessengerAppbar(
      {super.key, required this.name, required this.photoUrl});
  final String name;
  final String photoUrl;

  @override
  State<MessengerAppbar> createState() => _MessengerAppbarState();
}

class _MessengerAppbarState extends State<MessengerAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: AutoSizeText(
        widget.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: MessengerProfile(photoUrl: widget.photoUrl, radius: 16),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.call),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Iconsax.video),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Iconsax.close_circle4),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
