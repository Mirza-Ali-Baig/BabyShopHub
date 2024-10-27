import 'package:flutter/material.dart';

import '../../../utils/my_redirect.dart';
import '../screens/category_screen.dart';

BottomNavigationBar MyBottomNavigation(context) {
  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory),
        label: 'Products',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Reviews',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Users',
      ),
    ],
    currentIndex: 0,
    selectedItemColor: Colors.pink,
    onTap: (index) {
      // Navigate to the corresponding screen based on the index
      switch (index) {
        case 0:
          // Already on Dashboard
          break;
        case 1:
          Navigator.pushNamed(context, '/orders');
          break;
        case 2:
          Navigator.pushNamed(context, '/products');
          break;
        case 3:
          redirect(context, const CategoryScreen());
          break;
        case 4:
          Navigator.pushNamed(context, '/reviews');
          break;
        case 5:
          Navigator.pushNamed(context, '/users');
          break;
      }
    },
    type: BottomNavigationBarType.fixed,
  );
}
