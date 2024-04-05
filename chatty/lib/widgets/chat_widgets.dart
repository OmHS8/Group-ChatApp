import 'package:chatty/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  final String content;
  final DateTime time;
  final String userName;
  final bool isReceived;

  const ChatBubble({super.key, required this.content, required this.time, required this.userName, required this.isReceived});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.Hm().format(widget.time);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: widget.isReceived ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.isReceived)
            CircleAvatar(
              child: Text(widget.userName[0].toUpperCase()),
            ),
          const SizedBox(height: 4.0,),
          Expanded(
            child: Padding(
              padding:const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: widget.isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  if (widget.isReceived) 
                    Text(widget.userName, style: TextStyle(fontWeight: FontWeight.bold, color: Provider.of<AppProvider>(context).isDark ? Colors.white : Colors.black), ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Provider.of<AppProvider>(context).isDark ? Colors.black : Colors.white,
                      border: Border.all(width: 2,color: Provider.of<AppProvider>(context).isDark ? Colors.white : Colors.black,)
                    ),
                    child: Text(widget.content, style: const TextStyle(fontSize: 18.0)),
                  ),
                  const SizedBox(height: 4.0,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Provider.of<AppProvider>(context).isDark ? Colors.black : Colors.white,
                      border: Border.all(width: 2,color: Provider.of<AppProvider>(context).isDark ? Colors.white : Colors.black,)
                    ),
                    child: Text(formattedTime, style: const TextStyle(fontSize: 12.0)),
                  ),
                  
                ],
              )
            ),
          ),
          if (!widget.isReceived) 
            const SizedBox(width: 4.0,)
        ],
      ),
    );
  }
}