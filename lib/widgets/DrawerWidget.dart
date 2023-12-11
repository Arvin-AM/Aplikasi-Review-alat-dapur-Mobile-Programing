import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/login/login.dart';
import 'package:uas/pages/HomePage.dart';
import 'package:uas/widgets/ProfilWidget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              accountName: Text(
                user?.displayName ?? "",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user?.email ?? ""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/5556468.png"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.blueGrey,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilWidget()),
              );
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.blueGrey,
              ),
              title: Text(
                "My Profil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _auth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.blueGrey,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
