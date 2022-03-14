import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool checkLogin = _prefs.getBool("isLoggedIn") ?? false;
  runApp(MyApp(checkLogin));
}

class MyApp extends StatelessWidget {
  bool checkLogin;

  MyApp(this.checkLogin);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: checkLogin ? HomePage() : LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  setLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("isLoggedIn", true);
    showSimpleNotification(Text("You are logged In"), background: Colors.green);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: "username"),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter username";
                    } else {}
                  },
                ),
                space,
                TextFormField(
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: "password"),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter password";
                    } else {}
                  },
                ),
                SizedBox(height: 50.0),
                Container(
                    width: MediaQuery.of(context).size.width / 1.06,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setLoginStatus();
                          }
                        },
                        child: Text("Login")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
