import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// void main() => runApp(MyApp());

class GoogleSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleSignInDemo(),
    );
  }
}

class GoogleSignInDemo extends StatefulWidget {
  @override
  _GoogleSignInDemoState createState() => _GoogleSignInDemoState();
}

class _GoogleSignInDemoState extends State<GoogleSignInDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print("Sign in failed: $error");
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sign-In Example"),
      ),
      body: Center(
        child: _currentUser != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Signed in as: ${_currentUser?.displayName}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSignOut,
              child: Text("Sign Out"),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: _handleSignIn,
          child: Text("Sign In with Google"),
        ),
      ),
    );
  }
}
