// authProvider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/constants.dart' as constent;

import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print('Signed in with Google: ${account.displayName}');
        // Here you would send the token to your backend for further authentication
        // You can use account.authentication to get the Google authentication tokens
      }
    } catch (error) {
      print('Google sign-in failed: $error');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // Implement email/password sign-in logic
    print("Sign in with email: $email and password: $password");
    // Send these details to your backend for authentication
  }

  Future<void> signUpWithEmailAndPassword(String username, String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      print("Passwords don't match!");
      return;
    }
    // Implement sign-up logic with username, email, and password
    print("Sign up with username: $username, email: $email, password: $password");
    // Send these details to your backend for user creation
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      print('Signed out of Google');
    } catch (error) {
      print('Sign-out failed: $error');
    }
  }
}
