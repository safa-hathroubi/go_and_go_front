import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_model.dart';
import '../services/Config.dart';

class ChatProvider with ChangeNotifier {
  static var client = http.Client();

  List<Message> _messages = [];
  List<Message> get messages => [..._messages];

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => [..._conversations];

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Conversation> fetchConversationsForUser2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'token': 'Bearer $token'};
    var url = Uri.http(Config.apiUrl, Config.getCar);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var conversation = Conversation.fromJson(jsonDecode(response.body));
      return conversation;
    } else {
      debugPrint('status code: ${response.statusCode}');
      throw Exception("Failed to get the jobs");
    }
  }

  Future<List<Conversation>> fetchConversationsForUser(int userId) async {
    final String? token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlbW5hLmJnQGVzcHJpdC50biIsImZpcnN0TmFtZSI6Ik1vdWhpYiIsImxhc3ROYW1lIjoiQmVuIGdheWVzIiwicm9sZSI6MCwiaXNzIjoiaW5ldHVtIiwiR2VuZGVyIjoiTWFsZSIsImV4cCI6MTcxNDE1NTA1MiwidXNlciI6MSwiaWF0IjoxNzE0MDY4NjUyLCJlbWFpbCI6ImVtbmEuYmdAZXNwcml0LnRuIiwianRpIjoiMzQ1YjI4YzAtYmY1NS00MjI4LThmZTEtZTA3MjY0NmUwZGU1In0.O8UQdfmkgu8Rypk_fxceWBAQZwIEGzh-Pkb43XnMTTdAjNZfmd80QP4ENJlzLCkG0wEmHOVdu0ybAer2_I6AQA'; //await _getToken();

    final url = Uri.http('localhost:3000', '/conversation/getAllConversationsForTheAuthentifiedUser/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _conversations = data.map((conversation) => Conversation.fromJson(conversation)).toList();
      notifyListeners();
      return _conversations;
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<void> fetchMessages(int conversationId) async {
    final String? token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlbW5hLmJnQGVzcHJpdC50biIsImZpcnN0TmFtZSI6Ik1vdWhpYiIsImxhc3ROYW1lIjoiQmVuIGdheWVzIiwicm9sZSI6MCwiaXNzIjoiaW5ldHVtIiwiR2VuZGVyIjoiTWFsZSIsImV4cCI6MTcxNDE1NTA1MiwidXNlciI6MSwiaWF0IjoxNzE0MDY4NjUyLCJlbWFpbCI6ImVtbmEuYmdAZXNwcml0LnRuIiwianRpIjoiMzQ1YjI4YzAtYmY1NS00MjI4LThmZTEtZTA3MjY0NmUwZGU1In0.O8UQdfmkgu8Rypk_fxceWBAQZwIEGzh-Pkb43XnMTTdAjNZfmd80QP4ENJlzLCkG0wEmHOVdu0ybAer2_I6AQA'; //await _getToken();

final url = Uri.http('localhost:3000', '/conversation/getAllConversationsForTheAuthentifiedUser/$conversationId');
final response = await http.get(
  url,
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  },
);


    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _messages = data.map((message) => Message.fromJson(message)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(int senderId, int conversationId, String messageContent) async {
    final url = Uri.parse('http://localhost:3000/message/add/$senderId/$conversationId?body=$messageContent');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // Successfully sent message
      fetchMessages(conversationId);
    } else {
      throw Exception('Failed to send message');
    }
  }

}
