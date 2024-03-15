import 'package:flutter/material.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

import 'views/view.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String _title = 'Inicio';
  int _currentIndex = 0;

  static const List<Widget> _views = [
    HomeView(),
    Center(
      child: Text('No implementado'),
    )
  ];

  void _onItemSelected(index, title) {
    setState(() {
      _title = title;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _views[_currentIndex],
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        currentPosition: _currentIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}