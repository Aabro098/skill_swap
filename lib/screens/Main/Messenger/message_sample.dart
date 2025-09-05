import 'package:skill_swap/model/chat_message.dart';

final List<ChatMessage> messages = [
  ChatMessage(
    text: "Hey! How's it going?",
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  ChatMessage(
    text: "Hi! I'm good, thanks. How about you?",
    isMe: true,
    time: DateTime.now().subtract(const Duration(minutes: 13)),
  ),
  ChatMessage(
    text: "Doing well! Did you finish the project?",
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ChatMessage(
    text: "Yes, I sent it over this morning.",
    isMe: true,
    time: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  ChatMessage(
    text: "Great! Thanks for the update.",
    isMe: false,
    time: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
];
