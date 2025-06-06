import 'message_model.dart';

class ChatModel {
  final String id;
  final String title;
  final List<MessageModel> messages;
  final DateTime lastUpdated;

  ChatModel({
    required this.id,
    required this.title,
    required this.messages,
    required this.lastUpdated,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      title: json['title'],
      messages: (json['messages'] as List)
          .map((m) => MessageModel.fromJson(m))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((m) => m.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  String get lastMessage {
    if (messages.isEmpty) return '暂无消息';
    return messages.last.text;
  }
} 