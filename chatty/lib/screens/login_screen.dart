import 'package:chatty/providers/service_provider.dart';
import 'package:chatty/screens/final_chatscreen.dart';
// import 'package:chatty/screens/home.dart';`
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(

        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFFF800B), Color.fromARGB(186, 64, 138, 241)] 
                ),
              ),
            ),
          ),
          const Align(
            
            alignment: Alignment.center,   
            child: AnimatedLoginButton()),
        ]
      )
    );
  }
}



class AnimatedLoginButton extends StatefulWidget {
  const AnimatedLoginButton({super.key});

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  final double _width = 300;
  final double _height = 60;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(30);
  final Color _color = Colors.deepOrangeAccent;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 70.0, right: 70.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 183, 188, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: const Text(
                  'Enter your Username', 
                  style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                controller:_controller,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Center(
              child: GestureDetector(
                child: AnimatedContainer(
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: _borderRadius,
                  ),
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                  child: const Center(
                    child: Text(
                      'Join',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  )
                ),
                onTap: () {
                  String userName = _controller.text.trim();
                  if (userName.isNotEmpty) {
                    Provider.of<SocketService>(context, listen: false).setUserName(userName);  
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const ChatScreen()));
                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}