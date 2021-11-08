import 'dart:convert';

import 'package:finalproj/post_details.dart';
import 'package:finalproj/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:provider/src/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();

}

class _CreatePostState extends State<CreatePost> {

  bool enableBtn = false;

    //fetch API
  final fetchAPI = WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));

  void apiStream() {
    fetchAPI.stream.listen((message) {
      final decodedMessage = jsonDecode(message);

      // ignore: avoid_print
      print(decodedMessage);
    });
  }
  
  void _getToPost(String title, String description, String image) {
    fetchAPI.sink.add(
        '{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$image"}}');
  }

  Widget buildTitle(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget> [
      const Text(
        'Title',
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
              Icons.title_rounded,
            ),
            hintText: 'Enter Title',
            hintStyle: TextStyle(
              color: Colors.black38
            )
            )
          ),
        ),
    ],
  );
}

Widget buildDescription(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget> [
      const Text(
        'Description',
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
              Icons.description_rounded,
            ),
            hintText: 'Enter Description',
            hintStyle: TextStyle(
              color: Colors.black38
            )
            )
          ),
        ),
    ],
  );
}

Widget buildImage(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget> [
      const Text(
        'Image URL',
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
              Icons.image_rounded,
            ),
            hintText: 'Enter Image URL',
            hintStyle: TextStyle(
              color: Colors.black38
            )
            )
          ),
        ),
    ],
  );
}

  Widget buildCreatePostBtn(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Create Post'),
        onPressed: enableBtn ? null : () {
          /*context.read<MainCubit>().createPost(username.text,
                          title.text, description.text, image.text);*/
          /*String textInput = (usernameInput.toString());
          _getToPost();*/
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostDetails()),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0x99ffc0cb)
        )
      )
    );
  }

  Widget buildCancelBtn(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Cancel'),
        onPressed: () {
          // ignore: prefer_const_constructors
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()),
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
                    vertical: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const Text(
                        'Create new posts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildTitle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildDescription(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildImage(),
                      ),
                      buildCreatePostBtn(),
                      buildCancelBtn(),
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

/*// ignore_for_file: file_names, prefer_const_constructors, avoid_print
import 'package:finalprojectmobile/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<CreatePost> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, String>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: 'Post title',
                      ),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    TextFormField(
                      maxLines: 2,
                      controller: description,
                      decoration: const InputDecoration(
                        hintText: 'Image description',
                      ),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    Text(
                      'Image URL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    TextFormField(
                      controller: image,
                      decoration: const InputDecoration(
                        hintText: 'Image URL',
                      ),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                    Text(
                      'Author Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: 'Author Name',
                      ),
                    ),
                    Divider(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<MainCubit>().createPost(username.text,
                          title.text, description.text, image.text);

                      Navigator.popAndPushNamed(context, '/post_details');
                    },
                    child: Text('Create'),
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}*/