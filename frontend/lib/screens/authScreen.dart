import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            SizedBox(height: 100,),
            Image.asset(
              'assets/images/icons/google.png', // Replace with your logo URL or asset
              height: 150,
            ),
            SizedBox(height: 16),
            // App Title
            Text(
              'VeloCity',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Tab Bar for Login and Signup
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Signup'),
              ],
            ),
            SizedBox(height: 16),
            // Tab Bar View for showing Login and Signup forms
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Login Form
                  LoginForm(),
                  // Signup Form
                  SignupForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AuthProvider authProvider = AuthProvider();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email/Username',
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authProvider.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  authProvider.signInWithGoogle();
                },
                icon: Image.asset(
                  'assets/images/icons/google.png',
                  height: 25,
                  width: 25,
                ),
                label: Text('Sign in with Google', style: TextStyle(fontSize: 16, color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle forgot password action
                },
                child: Text('Forgot Password?'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  AuthProvider authProvider = AuthProvider();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Signup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: _emailController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: _userNameController,
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _passwordController,
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              controller: _confirmPasswordController,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authProvider.signUpWithEmailAndPassword(
                      _userNameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Signup', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  authProvider.signInWithGoogle();
                },
                icon: Image.asset(
                  'assets/images/icons/google.png',
                  height: 25,
                  width: 25,
                ),
                label: Text('Sign up with Google', style: TextStyle(fontSize: 16, color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
