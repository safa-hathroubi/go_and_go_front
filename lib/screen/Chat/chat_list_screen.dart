import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/chat_provider.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = 1;
    final chatProvider = Provider.of<ChatProvider>(context);
    chatProvider.fetchConversationsForUser(userId);

    final conversations = chatProvider.conversations;
    /*final conversations = [
      Conversation(
          id: 1,
          firstUser: User(
              id: 1,
              firstName: "Mouhib",
              lastName: "Ben gayes",
              email: "emna.bg@esprit.tn",
              mdp: 'password',
              phone: 92444888,
              gender: 'female',
              consumptionExpected: 1,
              active: true,
              verified: 1,
              dateCompte: '2024-04-24',
              role: 0),
          secondUser: User(
              id: 3,
              firstName: 'Ron',
              lastName: 'Weasley',
              email: 'ron.weasleyg@esprit.tn',
              mdp: 'password',
              phone: 92444888,
              gender: 'female',
              consumptionExpected: 1,
              active: true,
              verified: 1,
              dateCompte: '2024-04-24',
              role: 0)),
      Conversation(
          id: 1,
          firstUser: User(
              id: 1,
              firstName: "Safa",
              lastName: "Hathroubi",
              email: "safa@esprit.tn",
              mdp: 'password',
              phone: 92444888,
              gender: 'female',
              consumptionExpected: 1,
              active: true,
              verified: 1,
              dateCompte: '2024-04-24',
              role: 0),
          secondUser: User(
              id: 3,
              firstName: 'Rimene',
              lastName: 'Guediche',
              email: 'rimene@esprit.tn',
              mdp: 'password',
              phone: 92444888,
              gender: 'female',
              consumptionExpected: 1,
              active: true,
              verified: 1,
              dateCompte: '2024-04-24',
              role: 0)),
    ];*/

    //ChatProvider.fetchConversationsForUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: conversations.isEmpty
          ? Center(
              child: Text(
                'No chats available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(conversationId: conversation.id),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.blue,
                          child: Text(
                            conversation.secondUser.firstName[0],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                conversation.secondUser.firstName,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ), //.paddingOnly(top: 10),
                              SizedBox(height: 4),
                              Text(
                                'yesterday',
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
