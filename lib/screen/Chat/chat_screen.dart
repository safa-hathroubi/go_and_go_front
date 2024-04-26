import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/chat_provider.dart';
import '../../models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final int conversationId;

  ChatScreen({required this.conversationId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).fetchMessages(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    //final messages = chatProvider.messages;

    //int senderId = messages.isNotEmpty ? messages.first.sender.id : 0;

    final List<Message> messages = [
      Message(
        id: 1,
        body: 'Helloooooooooo',
        createdAt: '2024-04-24',
        conversation: Conversation(
          id: 1,
          firstUser: User(
            id: 1,
            firstName: 'Mouhib',
            lastName: 'Ben gayes',
            email: 'emna.bg@esprit.tn',
            mdp: 'password',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
          secondUser: User(
            id: 3,
            firstName: 'Ron',
            lastName: 'Weasley',
            email: 'ron.weasleyg@esprit.tn',
            mdp: '123456',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
        ),
        sender: User(
          id: 1,
          firstName: 'Mouhib',
          lastName: 'Ben gayes',
          email: 'emna.bg@esprit.tn',
          mdp: 'password',
          phone: 0,
          gender: 'Male',
          consumptionExpected: 0,
          active: true,
          verified: 1,
          dateCompte: '2024-04-24',
          role: 0,
        ),
      ),
      Message(
        id: 2,
        body: 'How are you??',
        createdAt: '2024-04-24',
        conversation: Conversation(
          id: 1,
          firstUser: User(
            id: 1,
            firstName: 'Mouhib',
            lastName: 'Ben gayes',
            email: 'emna.bg@esprit.tn',
            mdp: 'password',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
          secondUser: User(
            id: 3,
            firstName: 'Ron',
            lastName: 'Weasley',
            email: 'ron.weasleyg@esprit.tn',
            mdp: '123456',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
        ),
        sender: User(
          id: 1,
          firstName: 'Mouhib',
          lastName: 'Ben gayes',
          email: 'emna.bg@esprit.tn',
          mdp: 'password',
          phone: 0,
          gender: 'Male',
          consumptionExpected: 0,
          active: true,
          verified: 1,
          dateCompte: '2024-04-24',
          role: 0,
        ),
      ),
      Message(
        id: 3,
        body: '????',
        createdAt: '2024-04-24',
        conversation: Conversation(
          id: 1,
          firstUser: User(
            id: 1,
            firstName: 'Mouhib',
            lastName: 'Ben gayes',
            email: 'emna.bg@esprit.tn',
            mdp: 'password',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
          secondUser: User(
            id: 3,
            firstName: 'Ron',
            lastName: 'Weasley',
            email: 'ron.weasleyg@esprit.tn',
            mdp: '123456',
            phone: 0,
            gender: 'Male',
            consumptionExpected: 0,
            active: true,
            verified: 1,
            dateCompte: '2024-04-24',
            role: 0,
          ),
        ),
        sender: User(
          id: 1,
          firstName: 'Mouhib',
          lastName: 'Ben gayes',
          email: 'emna.bg@esprit.tn',
          mdp: 'password',
          phone: 0,
          gender: 'Male',
          consumptionExpected: 0,
          active: true,
          verified: 1,
          dateCompte: '2024-04-24',
          role: 0,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.sender.firstName),
                  subtitle: Text(message.body),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    chatProvider.sendMessage(
                      1, //senderId,
                      widget.conversationId,
                      _controller.text,
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
