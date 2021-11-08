import 'dart:convert';

import 'package:finalproj/create_post.dart';
import 'package:finalproj/fav_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();

}

class _PostScreenState extends State<PostScreen> {

    //fetch API
  final fetchAPI = WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));

  List post = [];
  List savedPost = [];

  void _getPostResponse() {
    fetchAPI.sink.add('{"type": "get_posts", "data":{"limit":10}}');
  }

  void apiStream() {
    fetchAPI.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      if (decodedMessage['type'] == 'all_posts') {
        post = decodedMessage['data']['posts'];
      }
      setState((){});
      // ignore: avoid_print
      print(decodedMessage);
    });
    _getPostResponse();
  }

  /*Widget buildAddPostBtn(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreatePost()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0x99ffc0cb),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }*/

  // ignore: non_constant_identifier_names
  Widget ListBuilder(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: post.length,
      itemBuilder: (context,index){
        bool isSaved = savedPost.contains([post][index]);
          return GestureDetector(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                  builder: (context) => const FavPost(),
                  settings: RouteSettings(
                    arguments: post[index],
                  ),
                ),
              );
            },
        child: Card(
          child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //image
                        Container(
                            margin: const EdgeInsets.only(right: 30, left: 8),
                            child: Center(
                                child: Image.network(
                                    '${post[index]["image"]}',
                                    // ignore: non_constant_identifier_names
                                    errorBuilder: (_1, _2, _3) => const SizedBox.shrink()))),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                post[index]["author"],
                                style: const TextStyle(fontSize: 23),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 13, 0, 13),
                                child: Text(
                                    post[index]["date"],
                                    style: const TextStyle(fontSize: 15),
                                  )),
                              Text("${post[index]["description"]}")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
        ),
      );
    });
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
                        Text(
                        'Posts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListBuilder(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreatePost()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffffc0cb), 
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}