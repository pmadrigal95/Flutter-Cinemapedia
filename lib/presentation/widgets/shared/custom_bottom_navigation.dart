import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom bottom navigation bar widget.
///
/// This widget represents a custom bottom navigation bar that can be used in a Flutter app.
/// It consists of three navigation items: "Inicio" with a home icon, "Categorías" with a label icon, and "Favoritos" with a favorite icon.
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});


  int getCurrentIndex( BuildContext context ) {

    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case '/':
        return 0;

      case '/categoties':
        return 1;
        
      case '/favorites':
        return 2; 

      default:
        return 0;
    }


  }


  void onItemTapped( BuildContext context, int index ) {

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
      default:
    }

  }

  @override
  Widget build(BuildContext context) {
    /// Builds the custom bottom navigation bar widget.
    ///
    /// This method returns a [BottomNavigationBar] widget with three navigation items.
    /// The [elevation] property is set to 0 to remove the shadow effect from the navigation bar.
    /// The [items] property is set to a list of [BottomNavigationBarItem] widgets, each representing a navigation item.
    /// The first item has an icon of a home ([Icons.home_max]) and a label of "Inicio".
    /// The second item has an icon of a label ([Icons.label_outline]) and a label of "Categorías".
    /// The third item has an icon of a favorite ([Icons.favorite_outline]) and a label of "Favoritos".
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      onTap: (index) => onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}