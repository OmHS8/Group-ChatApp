import 'package:chatty/providers/app_provider.dart';
import 'package:chatty/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_widgets.dart';

class ChatScreen extends StatefulWidget {


  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.abc),
        toolbarHeight: 80.0,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xff121212),
            width: 1.0
          )),
        shadowColor: Colors.black,
        title: Text(
          'Anonymous Chat', 
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w800)),
        centerTitle: true,
        backgroundColor:  isDark ? Colors.black87 : Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: !isDark ? Colors.white : Colors.black,
                border: Border.all(color: isDark ? Colors.white : Colors.black, width: 2)
              
              ),
              child: IconButton(
                icon: const Icon(Icons.dark_mode_rounded),
                color: isDark ? Colors.white : Colors.black,
                onPressed: () {
                  setState(() {
                    isDark = isDark ? false : true;
                  });
                  if (isDark) {
                    Provider.of<AppProvider>(context, listen: false).toggleThemeMode(isDark);
                  } else {
                    Provider.of<AppProvider>(context, listen: false).toggleThemeMode(isDark);
                  }
                },
                
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(12),
                  colors: [Color.fromARGB(255, 95, 48, 111), Color.fromARGB(255, 93, 38, 93)]
                )
              ),
              child: const Chat(),
            )
          ],
        )
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<SocketService>(
              builder: (context, socketService, child) {
                final messages = socketService.getMessages;
                return ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ChatBubble(
                        content: message.content,
                        time: message.time,
                        userName: message.userName,
                        isReceived: message.isReceived,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))
                ),
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.black,),
            onPressed: () {
              String message = _messageController.text.trim();
              if (message.isNotEmpty) {
                Provider.of<SocketService>(context, listen: false)
                    .sendMessage(message);
              }
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

