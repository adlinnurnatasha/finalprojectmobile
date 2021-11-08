import 'package:finalproj/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();

}

class _PostDetailsState extends State<PostDetails> {

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
                    children: const <Widget> [
                      Text(
                        'Posts Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()),
          );
        },
        child: const Icon(Icons.home),
        backgroundColor: const Color(0xffffc0cb), 
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}