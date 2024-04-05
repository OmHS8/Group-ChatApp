import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/service_provider.dart';
import 'final_chatscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: SweepGradient(
                  colors: [Colors.black, Color.fromARGB(255, 93, 38, 93)]
                )
              ),
              child: LoginContent(),
            )
          ],
        )
      ),
    );
  }
}

class LoginContent extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  LoginContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Sign Up', 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 60.0,
              fontWeight: FontWeight.bold
            )
          ),
          const Text(
            'Enter your Username',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0
            ),
          ),
          const SizedBox(height: 40.0,),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1.0))
              
            ),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white
              ),
              decoration: const InputDecoration(
                labelText: 'UserName',
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1.0))
                ),
                hintFadeDuration: Duration(microseconds: 100),
                
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _controller
            ),
          ),
          const SizedBox(height: 40.0,),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                String userName = _controller.text.trim();
                if (userName.isNotEmpty) {
                Provider.of<SocketService>(context, listen: false).setUserName(userName);  
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const ChatScreen()));
                    _controller.clear();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: Text(
                  'Join',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}