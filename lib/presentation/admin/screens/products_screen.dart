import 'package:baby_shop_hub/Core/Theme/my_colors.dart';
import 'package:baby_shop_hub/data/models/category_model.dart';
import 'package:baby_shop_hub/data/models/product_model.dart';
import 'package:baby_shop_hub/data/services/category_service.dart';
import 'package:baby_shop_hub/data/services/product_service.dart';
import 'package:flutter/material.dart';
import '../../../data/models/review_model.dart';
import '../components/my_appbar.dart';
import '../components/my_bottom_navigation.dart';
import '../components/my_product_card.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
   List<ProductModel> _products = [];
    final List<CategoryModel> _selectedCategory=[];

   @override
  void initState() {
    super.initState();
    _getProducts();
  }
  void _getProducts() async {
    try {
      _products = await _productService.getProducts();
      for (var product in _products) {
        final category = await _categoryService.getCategoryById(product.categoryID);
        _selectedCategory.add(category);
      }
      setState(() {
        // Update the UI with the fetched data
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddProductScreen()));
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Add Product'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 80, color: MyColors.textColor(context)),
                        const SizedBox(height: 16),
                        Text(
                          'No products added yet.',
                          style: TextStyle(
                              fontSize: 18, color: MyColors.textColor(context)),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle),
                          label: const Text('Add Your First Product'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                        ),
                      ],
                    ),
                  )
                :GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              return MyProductCard(product: _products[index],categoryName:_selectedCategory[index].name, onEdit: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProductScreen(product: _products[index])));
              }, onDelete: () {  },);
            },
          ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(context),
    );
  }
}
