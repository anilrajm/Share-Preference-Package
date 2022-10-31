import 'package:flutter/material.dart';
import 'package:share_preference/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference"),

      ),
      body: Padding(padding: EdgeInsets.all(26.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Hai $username Welcome to MechStore",style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold
              ),),
            ),ElevatedButton(onPressed: ( ){
              logindata.setBool('login', true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyLoginPage()));
            }, child: Text("LogOut"))
          ],
        ),),
    );
  }
}
