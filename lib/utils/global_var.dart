import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livit/screens/profile_screen.dart';

const webScreenSize = 600; // determine whether web or mobile

// bottom navigation bar items
List<Widget> homeScreenItems = [
  const Text('home'),
  const Text('explore'),
  const Text('message'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
