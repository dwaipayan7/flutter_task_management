import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Required for ScaffoldMessenger
import 'package:flutter_task_management/feature/auth/model/user_model.dart';
import 'package:flutter_task_management/feature/auth/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class AuthRepository {
  static String apiUrl = 'http://10.0.2.2:3000/api';
  static const String tokenKey = 'auth_token';

  // Add method to save token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  // Add method to get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Add method to clear token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        name: name,
        email: email,
        token: '',
        password: password,
      );

      final response = await http.post(
        Uri.parse("$apiUrl/signup"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userModel.toJson()),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        await _saveToken(token);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to create account');
      }
    } catch (e) {
      throw Exception('Failed to create account: ${e.toString()}');
    }
  }

  Future<UserModel> signinUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/signin"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password
        })
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        await _saveToken(token);
        
        return UserModel.fromJson(responseBody['user']);
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? "Failed to sign in");
      }
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await clearToken();
      // Navigate to login page or handle signout UI updates
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing out: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Helper method for authenticated requests
  Future<http.Response> authenticatedRequest(
    String endpoint,
    {
      required String method,
      Map<String, dynamic>? body,
    }
  ) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final uri = Uri.parse('$apiUrl/$endpoint');

    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(uri, headers: headers);
      case 'POST':
        return http.post(uri, headers: headers, body: jsonEncode(body));
      case 'PUT':
        return http.put(uri, headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return http.delete(uri, headers: headers);
      default:
        throw Exception('Unsupported HTTP method');
    }
  }
}