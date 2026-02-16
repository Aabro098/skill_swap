import 'package:skill_swap/model/base_model.dart';
import 'package:skill_swap/model/user_model.dart';

class ChatListResponse implements BaseModel {
  final List<ChatModel> chats;

  const ChatListResponse({
    required this.chats,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      chats: BaseModel.parseList(
            json['chats'],
            (e) => ChatModel.fromJson(e as Map<String, dynamic>),
          ) ??
          [],
    );
  }

  ChatListResponse copyWith({
    List<ChatModel>? chats,
  }) {
    return ChatListResponse(
      chats: chats ?? this.chats,
    );
  }
}

class MessageListResponse implements BaseModel {
  final List<MessageModel> messages;

  const MessageListResponse({
    required this.messages,
  });

  factory MessageListResponse.fromJson(Map<String, dynamic> json) {
    return MessageListResponse(
      messages: BaseModel.parseList(
            json['messages'],
            (e) => MessageModel.fromJson(e as Map<String, dynamic>),
          ) ??
          [],
    );
  }

  MessageListResponse copyWith({
    List<MessageModel>? messages,
  }) {
    return MessageListResponse(
      messages: messages ?? this.messages,
    );
  }
}

class ChatModel implements BaseModel {
  final UserModel user;
  final MessageModel lastMessage;

  const ChatModel({
    required this.user,
    required this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      lastMessage: MessageModel.fromJson(
        json['lastMessage'] as Map<String, dynamic>,
      ),
    );
  }

  ChatModel copyWith({
    UserModel? user,
    MessageModel? lastMessage,
  }) {
    return ChatModel(
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}

class MessageModel implements BaseModel {
  final String? id;
  final String? content;
  final DateTime? timestamp;
  final bool fromSelf;

  const MessageModel({
    this.id,
    this.content,
    this.timestamp,
    required this.fromSelf,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: BaseModel.parseString(json['_id']),
      content: BaseModel.parseString(json['content']),
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      fromSelf: BaseModel.parseBool(json['fromSelf']) ?? false,
    );
  }

  MessageModel copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? fromSelf,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      fromSelf: fromSelf ?? this.fromSelf,
    );
  }
}

// Dummy data for testing and development purposes
final List<ChatModel> dummyChats = [
  ChatModel(
    user: const UserModel(
      id: "u1",
      name: "Alice Johnson",
      email: "alice@example.com",
      description: "Flutter Developer",
      profileUrl: "",
      skills: ["Flutter", "Dart"],
      requestedSkills: ["Node.js"],
      isPremiumUser: false,
    ),
    lastMessage: MessageModel(
      content: "Are we meeting tomorrow?",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      fromSelf: false,
    ),
  ),
  ChatModel(
    user: const UserModel(
      id: "u2",
      name: "Brian Smith",
      email: "brian@example.com",
      description: "Backend Engineer",
      profileUrl: "",
      skills: ["Node.js", "MongoDB"],
      requestedSkills: ["Flutter"],
      isPremiumUser: true,
    ),
    lastMessage: MessageModel(
      content: "I'll push the API changes tonight.",
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      fromSelf: true,
    ),
  ),
  ChatModel(
    user: const UserModel(
      id: "u3",
      name: "Catherine Lee",
      email: "catherine@example.com",
      description: "UI/UX Designer",
      profileUrl: "",
      skills: ["Figma", "Adobe XD"],
      requestedSkills: ["Flutter"],
      isPremiumUser: false,
    ),
    lastMessage: MessageModel(
      content: "Can you review the latest design?",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      fromSelf: false,
    ),
  ),
  ChatModel(
    user: const UserModel(
      id: "u4",
      name: "David Kim",
      email: "david@example.com",
      description: "Machine Learning Enthusiast",
      profileUrl: "",
      skills: ["Python", "TensorFlow"],
      requestedSkills: ["Data Engineering"],
      isPremiumUser: false,
    ),
    lastMessage: MessageModel(
      content: "Let's collaborate on the ML project.",
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      fromSelf: false,
    ),
  ),
  ChatModel(
    user: const UserModel(
      id: "u5",
      name: "Emma Wilson",
      email: "emma@example.com",
      description: "Full Stack Developer",
      profileUrl: "",
      skills: ["React", "Node.js", "Flutter"],
      requestedSkills: ["DevOps"],
      isPremiumUser: true,
    ),
    lastMessage: MessageModel(
      content: "Deployment completed successfully.",
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      fromSelf: true,
    ),
  ),
];

//dummy messages for testing and development purposes
final List<MessageModel> dummyMessages = [
  MessageModel(
    id: "m1",
    content:
        "Hey, are you available for a quick call? I have some questions about the project.",
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    fromSelf: false,
  ),
  MessageModel(
    id: "m2",
    content: "Yes, give me 5 minutes.",
    timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    fromSelf: true,
  ),
  MessageModel(
    id: "m3",
    content: "I’ve pushed the latest changes to the repo.",
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    fromSelf: true,
  ),
  MessageModel(
    id: "m4",
    content: "Great, I’ll review them tonight. Thanks for the update!",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    fromSelf: false,
  ),
  MessageModel(
    id: "m5",
    content: "Deployment failed due to a config issue.",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    fromSelf: true,
  ),
];
