import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom bottom navigation bar widget.
///
/// This widget represents a custom bottom navigation bar that can be used in a Flutter app.
/// It consists of three navigation items: "Inicio" with a home icon, "Categorías" with a label icon, and "Favoritos" with a favorite icon.
class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
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
      currentIndex: currentIndex,
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
