import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _login() {
    // Add login logic here
    print(
      "Login: ${_loginEmailController.text}, ${_loginPasswordController.text}",
    );
  }

  void _signup() {
    // Add signup logic here
    print(
      "Sign Up: ${_signupEmailController.text}, ${_signupPasswordController.text}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter "),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Sign In"),
            Tab(text: "Sign Up"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Sign In Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _loginEmailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: _loginPasswordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _login, child: Text("Login")),
              ],
            ),
          ),

          // Sign Up Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _signupEmailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: _signupPasswordController,
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _signup, child: Text("Sign Up")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
