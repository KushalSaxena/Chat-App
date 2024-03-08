import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFFc199cd,)),
                    SizedBox(width: 135.0,),
                    Text("ChatUp",
                      style: TextStyle(color: Color(0xFFc199cd),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20, top: 50, bottom: 40.0),
                height: MediaQuery.of(context).size.height/1.16,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/2),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 236, 240),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                      ),
                      child: Text("Hello", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 211, 228, 243),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Text("Hello, how are you", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                    Spacer(),
                    Material(
                      elevation: 5.0,
                        borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(border: InputBorder.none,
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(color: Colors.black45)
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(color: Color(0xFFf3f3f3), borderRadius: BorderRadius.circular(60)),
                                child: Center(
                                    child: Icon(Icons.send, color: Color.fromARGB(255, 164, 154, 154),)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
