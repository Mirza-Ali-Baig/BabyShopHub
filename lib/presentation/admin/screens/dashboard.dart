import 'package:baby_shop_hub/data/models/product_model.dart';
import 'package:baby_shop_hub/utils/my_redirect.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/models/review_model.dart';
import '../components/my_appbar.dart';
import 'category_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSlider(),
            const OverviewSection(),
            RecentProductsSection(),
            RecentOrdersSection(),
            RecentReviewsSection(),
            RecentUsersSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
      )
    );
  }
}

// Hero Slider Widget


class HeroSlider extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'https://cdn.pixabay.com/photo/2024/02/20/09/13/cookies-8585032_960_720.png',
      'heading': 'Delicious Cookies',
      'description': 'Freshly baked cookies with chocolate chips.',
    },
    {
      'image': 'https://cdn.pixabay.com/photo/2024/02/20/09/13/cookies-8585032_960_720.png',
      'heading': 'Tasty Treats',
      'description': 'A variety of treats to satisfy your sweet tooth.',
    },
    {
      'image': 'https://via.placeholder.com/800x400?text=Slide+3',
      'heading': 'Slide 3 Title',
      'description': 'Description for Slide 3.',
    },
    {
      'image': 'https://via.placeholder.com/800x400?text=Slide+4',
      'heading': 'Slide 4 Title',
      'description': 'Description for Slide 4.',
    },
    {
      'image': 'https://via.placeholder.com/800x400?text=Slide+5',
      'heading': 'Slide 5 Title',
      'description': 'Description for Slide 5.',
    },
  ];

   HeroSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0), // Add margin around the slider
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0), // Round borders
      ),
      clipBehavior: Clip.antiAlias, // Add overflow to box for rounded border
      child: CarouselSlider.builder(
        itemCount: items.length,
        itemBuilder: (context, index, realIndex) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(items[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      items[index]['heading']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      items[index]['description']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Handle edit action here
                  },
                ),
              ),
            ],
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1.0,
        ),
      ),
    );
  }
}



// Overview Section Widget
class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              OverviewCard(title: 'Products', count: 120, icon: Icons.inventory),
              OverviewCard(title: 'Users', count: 300, icon: Icons.people),
              OverviewCard(title: 'Orders', count: 150, icon: Icons.shopping_cart),
              OverviewCard(title: 'Total Reviews', count: 450, icon: Icons.star),
              OverviewCard(title: 'Total Sales', count: '\$20,000', icon: Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }
}

// Overview Card Widget
class OverviewCard extends StatelessWidget {
  final String title;
  final dynamic count;
  final IconData icon;

  const OverviewCard({super.key, required this.title, required this.count, required this.icon});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor.withOpacity(0.7), Theme.of(context).primaryColor],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: isSmallScreen ? 28 : 36, color: Colors.white),
                  SizedBox(height: isSmallScreen ? 6 : 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmallScreen ? 4 : 6),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Charts Section Widget
class ChartsSection extends StatelessWidget {
  const ChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData: const FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(spots: [const FlSpot(1, 1), const FlSpot(2, 2), const FlSpot(3, 3)]),
          ],
        ),
      ),
    );
  }
}

// Recent Products Section Widget

class RecentProductsSection extends StatelessWidget {
  final List<ProductModel> products = [
    ProductModel(
      id: "1",
      categoryID: "1",
      quantity: 100,
      thumbnail: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
      images: ['https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80'],
      createdAt: DateTime.now(),
      title: 'Product 1',
      description: 'This is a short description of Product 1.',
      reviews: [ReviewModel(userId: "1", comment: "This is a great product!", rating: 5, date: DateTime.now())],
      price: 20.0,
    ),
    // Add more product instances as needed
  ];

  RecentProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ],
      ),
    );
  }
}

// Product Class
class Product {
  final String image;
  final String title;
  final String description;
  final int reviews;
  final String price;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.reviews,
    required this.price,
  });
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              // Implement product details action
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'product-${product.title}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            product.thumbnail,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "\$ ${product.price.toString()}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category: ${product.categoryID}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Quantity: ${product.quantity}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: isSmallScreen ? 14 : 18),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      '${product.reviews.length} reviews',
                                      style: TextStyle(fontSize: isSmallScreen ? 10 : 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    // Implement edit action
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 18),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    // Implement delete action
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// Recent Orders Section Widget

class RecentOrdersSection extends StatelessWidget {
   RecentOrdersSection({super.key});

  final List<Order> orders = [
    Order(
      orderNo: '001',
      image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
      title: 'Product 1',
      status: 'Shipped',
    ),
    Order(
      orderNo: '002',
      image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
      title: 'Product 2',
      status: 'Pending',
    ),
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Orders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          ),
        ],
      ),
    );
  }
}

// Order Class
class Order {
  final String orderNo;
  final String image;
  final String title;
  final String status;

  Order({
    required this.orderNo,
    required this.image,
    required this.title,
    required this.status,
  });
}

// Order Card Widget
class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(order.image, width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order No: ${order.orderNo}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(order.title, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.blue),
                  onPressed: () {
                    // Implement view more action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    // Implement edit status action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.green;
      case 'delivered':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

// 
class RecentReviewsSection extends StatelessWidget {
   RecentReviewsSection({super.key});

  final List<ReviewModel> reviews = [
    ReviewModel(
      userId: 'Alice',
      comment: 'Great product! Really happy with my purchase.',
      date: DateTime.now(),
      rating: 5,
    ),
    ReviewModel(
      userId: 'Bob',
      comment: 'Okay, but it could be better.',
      date: DateTime.now(),
      rating: 3,
    ),
    ReviewModel(
      userId: 'Charlie',
      comment: 'Absolutely fantastic! Highly recommend.',
      date: DateTime.now(),
      rating: 5,
    ),
    // Add more reviews as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Reviews', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: reviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index]);
            },
          ),
        ],
      ),
    );
  }
}


// Review Card Widget
class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(review.userId, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.userId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    review.comment,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      int.parse(review.rating.toString()),
                      (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Implement edit action
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Recent Users Section Widget

class RecentUsersSection extends StatelessWidget {
   RecentUsersSection({super.key});

  final List<User> users = [
    User(
      name: 'Alice Johnson',
      email: 'alice@example.com',
      image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1740&q=80',
    ),
    User(
      name: 'Bob Smith',
      email: 'bob@example.com',
      image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
    ),
    User(
      name: 'Charlie Brown',
      email: 'charlie@example.com',
      image: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80',
    ),
    // Add more users as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Users', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: users.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return UserCard(user: users[index]);
            },
          ),
        ],
      ),
    );
  }
}

// User Class
class User {
  final String name;
  final String email;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.image,
  });
}

// User Card Widget
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(user.image, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(user.email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Implement edit action
              },
            ),
          ],
        ),
      ),
    );
  }
}