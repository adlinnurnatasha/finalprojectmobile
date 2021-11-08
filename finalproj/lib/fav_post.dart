import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavPost extends StatefulWidget {
  const FavPost({Key? key}) : super(key: key);

  @override
  _FavPostState createState() => _FavPostState();

}

class _FavPostState extends State<FavPost> {
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
                        'Favourite Posts',
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
    );
  }
}
