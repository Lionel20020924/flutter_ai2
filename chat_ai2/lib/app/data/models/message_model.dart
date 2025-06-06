class MessageModel {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      text: json['text'],
      isFromUser: json['isFromUser'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isFromUser': isFromUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }
} 