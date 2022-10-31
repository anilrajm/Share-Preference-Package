import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Pref",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_already_login();
  }

  check_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHome()));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ), Padding(padding: EdgeInsets.all(15),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'username'
                ),
              ),), Padding(padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "password"
                ),
              ),), ElevatedButton(onPressed: () {
              String username = username_controller.text;
              String password = password_controller.text;
              if (username != '' && password != '') {
                print('Successfull');
                logindata.setBool('login', false);
                logindata.setString('username', username);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyHome()));
              }
            }, child:Text("Log-In"))
          ],
        ),
      ),
    );
  }
}
