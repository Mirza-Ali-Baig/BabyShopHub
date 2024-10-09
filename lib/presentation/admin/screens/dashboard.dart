import 'package:baby_shop_hub/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Row(
          children: [
            Image.asset(
              AssetsRes.LOGO, // Placeholder logo image
              height: 40,
            ),
            SizedBox(width: 10),
            Text('Welcome Admin'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Slider
            HeroSlider(),
            // Overview Section
            OverviewSection(),
            // Charts Section
            // ChartsSection(),
            // Recent Products Section
            RecentProductsSection(),
            // Recent Orders Section
            RecentOrdersSection(),
            // Recent Reviews Section
            RecentReviewsSection(),
            // Recent Users Section
            RecentUsersSection(),
          ],
        ),
      ),
      // bottomNavigationBar: FancyBottomNavigation(
      //   tabs: [
      //     TabData(iconData: Icons.home, title: "Home"),
      //     TabData(iconData: Icons.shopping_cart, title: "Orders"),
      //     TabData(iconData: Icons.settings, title: "Settings"),
      //   ],
      //   onTabChangedListener: (position) {
      //     setState(() {
      //       _currentIndex = position;
      //     });
      //   },
      // ),
    );
  }
}

// Hero Slider Widget
class HeroSlider extends StatelessWidget {
  final List<String> images = [
    'https://cdn.pixabay.com/photo/2024/02/20/09/13/cookies-8585032_960_720.png',
    'https://cdn.pixabay.com/photo/2024/02/20/09/13/cookies-8585032_960_720.png',
    'https://via.placeholder.com/800x400?text=Slide+3',
    'https://via.placeholder.com/800x400?text=Slide+4',
    'https://via.placeholder.com/800x400?text=Slide+5',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
      ),
    );
  }
}
// Overview Section Widget
class OverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          OverviewCard(title: 'Products', count: 120),
          OverviewCard(title: 'Users', count: 300),
          OverviewCard(title: 'Orders', count: 150),
          OverviewCard(title: 'Total Reviews', count: 450),
          OverviewCard(title: 'Total Sales', count: '\$20,000'),
        ],
      ),
    );
  }
}

// Overview Card Widget
class OverviewCard extends StatelessWidget {
  final String title;
  final dynamic count;

  const OverviewCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 20)),
            Text('$count', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Charts Section Widget
class ChartsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(spots: [FlSpot(1, 1), FlSpot(2, 2), FlSpot(3, 3)]),
          ],
        ),
      ),
    );
  }
}

// Recent Products Section Widget
class RecentProductsSection extends StatelessWidget {
  final List<String> productImages = [
    'https://via.placeholder.com/150?text=Product+1',
    'https://via.placeholder.com/150?text=Product+2',
    'https://via.placeholder.com/150?text=Product+3',
    'https://via.placeholder.com/150?text=Product+4',
    'https://via.placeholder.com/150?text=Product+5',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Products', style: TextStyle(fontSize: 24)),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: productImages.length,
            itemBuilder: (context, index) {
              return ProductCard(image: productImages[index], title: 'Product $index', price: '\$${index * 10 + 10}');
            },
          ),
        ],
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const ProductCard({required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(image, fit: BoxFit.cover, height: 100,scale: 1,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontSize: 18)),
          ),
          Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

// Recent Orders Section Widget
class RecentOrdersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Orders', style: TextStyle(fontSize: 24)),
          // Add your order cards here
        ],
      ),
    );
  }
}

// Recent Reviews Section Widget
class RecentReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Reviews', style: TextStyle(fontSize: 24)),
          // Add your review cards here
        ],
      ),
    );
  }
}

// Recent Users Section Widget
class RecentUsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Users', style: TextStyle(fontSize: 24)),
          // Add your user cards here
        ],
      ),
    );
  }
}