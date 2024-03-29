import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

 const MenuItem({
    required this.title, 
    required this.link, 
    required this.icon
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: "Inicio", 
    link: '/home', 
    icon: Icons.home
  ),

  MenuItem(
    title: "Favoritos", 
    link: '/favorites', 
    icon: Icons.favorite
  ),
];