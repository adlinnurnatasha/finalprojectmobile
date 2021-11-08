import 'dart:convert';
import 'package:finalproj/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final usernameInput = TextEditingController();
  bool enableBtn = false;
  String? name;
  
  void checkText() {
    if (usernameInput.text.isNotEmpty) {
      enableBtn = true;
    } else {
      enableBtn = false;
    }
  }

  void _getPostResponse() {
    fetchAPI.sink.add('{"type": "get_posts"}');
  }

  //fetch API
  final fetchAPI = WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));

  @override
  void dispose() {
    usernameInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    apiStream();

    usernameInput.addListener((checkText));
    super.initState();
  }

  void apiStream() {
    fetchAPI.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      if (decodedMessage['type'] == 'all_posts') {
        posts = decodedMessage['data']['posts'];
      }
      setState(() {
      });
      _getPostResponse();

      // ignore: avoid_print
      print(decodedMessage);
    });
  }

  List posts = [];
  
  Widget buildUsername(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget> [
      const Text(
        'Username',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 40,
        child: const TextField(
          keyboardType: TextInputType.name,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsetsDirectional.all(10),
            prefixIcon: Icon(
              Icons.people_outline_rounded,
            ),
            hintText: 'Enter Username',
            hintStyle: TextStyle(
              color: Colors.black38
            )
            )
          ),
        ),
    ],
  );
}

void _getSignInResponse(String userInput) {
    fetchAPI.sink.add('{"type": "sign_in", "data": {"name": "$userInput"}}');
  }

  Widget buildLoginBtn(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Enter to the app'),
        onPressed: enableBtn ? null : () {
          String textInput = (usernameInput.toString());
          _getSignInResponse(textInput);
          //_getPostResponse();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0x99ffc0cb)
        )
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x66ffc0cb),
                      Color(0x99ffc0cb),
                      Color(0xccffc0cb),
                      Color(0xffffc0cb),
                    ] 
                  )
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    buildUsername(),
                    buildLoginBtn(),
                  ],
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}