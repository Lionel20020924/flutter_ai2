import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  late SharedPreferences _prefs;
  final _isLoggedIn = false.obs;
  final _currentUser = Rxn<String>();

  bool get isLoggedIn => _isLoggedIn.value;
  String? get currentUser => _currentUser.value;

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadUserSession();
    return this;
  }

  Future<void> _loadUserSession() async {
    final token = _prefs.getString('auth_token');
    final username = _prefs.getString('username');
    
    if (token != null && username != null) {
      _isLoggedIn.value = true;
      _currentUser.value = username;
    }
  }

  Future<bool> login(String username, String password) async {
    // Simulate login API call
    await Future.delayed(Duration(seconds: 1));
    
    // Simple validation for demo
    if (username.isNotEmpty && password.isNotEmpty) {
      await _prefs.setString('auth_token', 'demo_token_123');
      await _prefs.setString('username', username);
      
      _isLoggedIn.value = true;
      _currentUser.value = username;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('username');
    
    _isLoggedIn.value = false;
    _currentUser.value = null;
  }
} 