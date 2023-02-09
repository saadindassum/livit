import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livit/screens/add_post_screen.dart';
import 'package:livit/screens/feed_screen.dart';
import 'package:livit/screens/profile_screen.dart';
import 'package:livit/screens/search_screen.dart';

const webScreenSize = 600; // determine whether web or mobile

// bottom navigation bar items
List<Widget> homeScreenItems = [
  const SearchScreen(),
  const AddPostScreen(),
  const FeedScreen(),
  const Text('notif'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
