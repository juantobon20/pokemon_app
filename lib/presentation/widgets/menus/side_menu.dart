import 'package:flutter/material.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int currentPosition;
  final Function(int index, String title) onItemSelected;
  
  const SideMenu({
    super.key, 
    required this.scaffoldKey,
    required this.currentPosition,
    required this.onItemSelected
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    navDrawerIndex = widget.currentPosition;
    
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;

          final menuItem = appMenuItems[value];
          widget.onItemSelected(navDrawerIndex, menuItem.title);
          
          widget.scaffoldKey.currentState?.closeDrawer();
        });
      },
      children: [

        Padding(padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10)),

        ...appMenuItems
          .map((e) => 
           NavigationDrawerDestination(
              icon: Icon(e.icon), 
              label: Text(e.title)) 
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        CustomButton(
          text: 'Cerrar sesión', 
          onPressedCallback: () {}
        )

        /*

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text("More options"),
        ),

        ...appMenuItems
          .sublist(3)
          .map((e) => 
           NavigationDrawerDestination(
              icon: Icon(e.icon), 
              label: Text(e.title)) 
        ),*/
      ],
    );
  }
}