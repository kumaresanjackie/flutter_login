import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width / 1.06,
              height: 50.0,
              color: Colors.cyanAccent,
              child: Text(
                "Welcome to homepage",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 25.0),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.06,
                child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await _prefs;
                      prefs.setBool("isLoggedIn", false);
                      showSimpleNotification(Text("You are logged Out"),
                          background: Colors.red);
                    },
                    child: Text("Logout")))
          ],
        ),
      ),
    );
  }
}
