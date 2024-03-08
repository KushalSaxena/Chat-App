import 'package:chat_app/pages/home.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email="", password="", name="", confirmPassword="";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async{
    if(password!=null && password==confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        String Id = randomAlphaNumeric(10);
        Map<String,dynamic>userInfoMap = {
          "Name" : nameController.text,
          "E-mail" : emailController.text,
          "Username" : emailController.text.replaceAll("@gmail.com", ""),
          "Photo" : "images/business/jpg",
          "Id" : Id,
        };
        await DataBaseMethods().addUserDetails(userInfoMap, Id);
        await SharedPrefrenceHelper().saveUserId(Id);
        await SharedPrefrenceHelper().saveUserDisplayName(nameController.text);
        await SharedPrefrenceHelper().saveUserEmail(emailController.text);
        await SharedPrefrenceHelper().saveName(emailController.text.replaceAll("@gmail.com", ""));
        await SharedPrefrenceHelper().saveUserPic("images/business/jpg");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Registered Successfully",
            style: TextStyle(fontSize: 20.0),),));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }
      on FirebaseAuthException catch (e){
        if(e.code == 'weak password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor : Colors.orangeAccent,content: Text(
            "Paswword provided is too weak", style: TextStyle(fontSize: 18.0),)));
        }
        else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orangeAccent, content: Text(
            "Account already exists", style: TextStyle(fontSize: 18.0),)));
        }
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF7f30fe), Color(0xFF6380fb)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                          "SignUp", style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),)),
                    Center(
                      child: Text(
                        "Create a new account", style: TextStyle(
                          color:Color(0xFFbbb0ff) , fontSize: 18.0, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                          height: MediaQuery.of(context).size.height/1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),),
                                SizedBox(height: 10.0),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all
                                        (width: 1.0, color: Colors.black38), borderRadius: BorderRadius.circular(10.0)),
                                  child: TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if(value==null || value.isEmpty){
                                        return "Please Enter Name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none, prefixIcon: Icon(Icons.person_outline, color: Color(0xFF7f30fe),)),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text("Email", style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),),
                                SizedBox(height: 10.0),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all
                                        (width: 1.0, color: Colors.black38), borderRadius: BorderRadius.circular(10.0)),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return 'Enter your email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none, prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF7f30fe),)),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text("Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),),
                                SizedBox(height: 10.0),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all
                                        (width: 1.0, color: Colors.black38), borderRadius: BorderRadius.circular(10.0)),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return 'Please Enter Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none, prefixIcon: Icon(Icons.password, color: Color(0xFF7f30fe),)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 20.0,),
                                Text("Confirm Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18.0),),
                                SizedBox(height: 10.0),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all
                                        (width: 1.0, color: Colors.black38), borderRadius: BorderRadius.circular(10.0)),
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return 'Please Enter Confirm Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none, prefixIcon: Icon(Icons.password, color: Color(0xFF7f30fe),)),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 30.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account?", style: TextStyle(color: Colors.black, fontSize: 16.0),),
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text(" Sign In Now!", style: TextStyle(color: Color(0xFF7f30fe), fontSize: 16.0, fontWeight: FontWeight.w500),))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            name = nameController.text;
                            password = passwordController.text;
                            confirmPassword = confirmPasswordController.text;
                          });
                        }
                        registration();
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            elevation: 5.0,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Color(0xFF6380fb), borderRadius: BorderRadius.circular(10.0)),
                                child: Center(
                                  child: Text(
                                    "SIGNUP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
