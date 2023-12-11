import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas/login/firebase_auth_service.dart';
import 'package:uas/login/login.dart';
import 'package:uas/pages/HomePage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _namaController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String nama = _namaController.text;
    String phone = _phoneController.text;

    User? user =
        await _authService.signUpWithEmailandPassword(email, password, context);

    if (user != null) {
      // Set display name pengguna
      await user.updateProfile(displayName: nama);

      // Simpan data user ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nama': nama,
        'email': email,
        'phone': phone,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User is successfully created"),
        backgroundColor: Colors.green,
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot create user"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person), hintText: "Full nama"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), hintText: "Email Address"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key), hintText: "Password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone), hintText: "Phone Number"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                onPressed: () {
                  register();
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                const SizedBox(
                  width: 8.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Login.",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
