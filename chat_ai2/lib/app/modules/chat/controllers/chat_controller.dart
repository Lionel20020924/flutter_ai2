import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/message_model.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  
  late ChatModel currentChat;
  final messages = <MessageModel>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
    currentChat = Get.arguments as ChatModel;
    messages.value = currentChat.messages;
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || isSending.value) return;
    
    // Add user message
    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isFromUser: true,
      timestamp: DateTime.now(),
    );
    
    messages.add(userMessage);
    messageController.clear();
    _scrollToBottom();
    
    // Simulate AI response
    isSending.value = true;
    await _simulateAIResponse(text);
    isSending.value = false;
  }

  Future<void> _simulateAIResponse(String userMessage) async {
    // Simulate thinking delay
    await Future.delayed(Duration(seconds: 1));
    
    // Simple AI responses for demo
    String response = _generateAIResponse(userMessage);
    
    final aiMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: response,
      isFromUser: false,
      timestamp: DateTime.now(),
    );
    
    messages.add(aiMessage);
    _scrollToBottom();
  }

  String _generateAIResponse(String userMessage) {
    final lowerCase = userMessage.toLowerCase();
    
    if (lowerCase.contains('你好') || lowerCase.contains('hello')) {
      return '你好！很高兴与你聊天，有什么我可以帮助你的吗？';
    } else if (lowerCase.contains('flutter')) {
      return 'Flutter是Google开发的UI工具包，用于构建漂亮的原生应用。它使用Dart语言，具有热重载、丰富的组件库等特性。你想了解Flutter的哪个方面？';
    } else if (lowerCase.contains('编程') || lowerCase.contains('代码')) {
      return '编程是一门很有趣的技能！无论是前端、后端还是移动开发，都有各自的魅力。你对哪种编程语言或技术栈比较感兴趣？';
    } else if (lowerCase.contains('学习')) {
      return '学习新技能需要持续的练习和实践。建议你可以：\n1. 制定学习计划\n2. 多动手实践\n3. 参与开源项目\n4. 与其他开发者交流\n\n你想学习什么技能？';
    } else if (lowerCase.contains('谢谢') || lowerCase.contains('thanks')) {
      return '不客气！如果还有其他问题，随时可以问我。';
    } else {
      return '这是一个很有趣的问题！作为AI助手，我会尽力帮助你。不过我目前只是一个演示版本，功能还比较简单。你还有其他问题吗？';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void clearChat() {
    Get.dialog(
      AlertDialog(
        title: Text('清空对话'),
        content: Text('确定要清空所有消息吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              messages.clear();
              Get.back();
            },
            child: Text('清空'),
          ),
        ],
      ),
    );
  }
} 