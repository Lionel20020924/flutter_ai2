import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/message_model.dart';
import '../../../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class ChatListController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final chatList = <ChatModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  Future<void> loadChats() async {
    isLoading.value = true;
    
    // Simulate loading chats from API
    await Future.delayed(Duration(seconds: 1));
    
    // Demo data
    chatList.value = [
      ChatModel(
        id: '1',
        title: 'AI助手对话',
        messages: [
          MessageModel(
            id: '1',
            text: '你好！我是AI助手，有什么可以帮助你的吗？',
            isFromUser: false,
            timestamp: DateTime.now().subtract(Duration(hours: 1)),
          ),
        ],
        lastUpdated: DateTime.now().subtract(Duration(hours: 1)),
      ),
      ChatModel(
        id: '2',
        title: '编程学习',
        messages: [
          MessageModel(
            id: '2',
            text: '我想学习Flutter开发',
            isFromUser: true,
            timestamp: DateTime.now().subtract(Duration(hours: 2)),
          ),
          MessageModel(
            id: '3',
            text: 'Flutter是Google开发的跨平台框架，非常适合移动应用开发...',
            isFromUser: false,
            timestamp: DateTime.now().subtract(Duration(hours: 2)),
          ),
        ],
        lastUpdated: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ];
    
    isLoading.value = false;
  }

  void openChat(ChatModel chat) {
    Get.toNamed(AppRoutes.CHAT, arguments: chat);
  }

  void createNewChat() {
    final newChat = ChatModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '新对话',
      messages: [],
      lastUpdated: DateTime.now(),
    );
    
    chatList.insert(0, newChat);
    openChat(newChat);
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void deleteChat(ChatModel chat) {
    Get.dialog(
      AlertDialog(
        title: Text('删除对话'),
        content: Text('确定要删除这个对话吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              chatList.removeWhere((c) => c.id == chat.id);
              Get.back();
            },
            child: Text('删除'),
          ),
        ],
      ),
    );
  }
} 