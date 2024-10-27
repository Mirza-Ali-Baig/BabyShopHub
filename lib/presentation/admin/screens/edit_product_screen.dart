import 'dart:io';
import 'package:baby_shop_hub/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baby_shop_hub/Core/Theme/my_colors.dart';
import 'package:baby_shop_hub/data/models/product_model.dart';
import 'package:baby_shop_hub/data/services/category_service.dart';
import 'package:baby_shop_hub/data/services/product_service.dart';
import 'package:baby_shop_hub/presentation/admin/components/my_appbar.dart';
import 'package:baby_shop_hub/presentation/admin/screens/products_screen.dart';
import 'package:dotted_border/dotted_border.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productsService = ProductService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  
  List<CategoryModel> _categoryList = [];
  String? _selectedCategory;
  File? _mainImage;
  final List<File> _smallImages = [];
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _initializeFields();
  }

  void _initializeFields() {
    _titleController.text = widget.product.title;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _quantityController.text = widget.product.quantity.toString();
    _selectedCategory = widget.product.categoryID;
    _mainImage = File(widget.product.thumbnail);
    _smallImages.addAll(widget.product.images.map((img) => File(img)).toList());
  }

  Future<void> _getAllCategories() async {
    _categoryList = await _categoryService.getCategories();
    setState(() {});
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final ProductModel updatedProduct = ProductModel(
        id: widget.product.id,
        categoryID: _selectedCategory!,
        description: _descriptionController.text,
        title: _titleController.text,
        price: double.parse(_priceController.text),
        reviews: widget.product.reviews,
        quantity: int.parse(_quantityController.text),
        thumbnail: _mainImage?.path ?? widget.product.thumbnail,
        images: _smallImages.map((e) => e.path).toList(),
        createdAt: widget.product.createdAt,
      );

      try {
        await _productsService.updateProduct(
          updatedProduct.id,
          updatedProduct,
          _mainImage,
          _smallImages.isNotEmpty ? _smallImages : null,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProductsScreen()));
      } catch (e) {
        _showSnackBar('Error updating product: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _chooseMainImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _mainImage = File(image.path);
      });
    }
  }

  Future<void> _chooseSmallImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.length + _smallImages.length <= 4) {
      setState(() {
        _smallImages.addAll(images.map((e) => File(e.path)));
      });
    } else {
      _showSnackBar('You can select a maximum of 4 images.');
    }
  }

  void _removeMainImage() {
    setState(() {
      _mainImage = null;
    });
  }

  void _removeSmallImage(int index) {
    setState(() {
      _smallImages.removeAt(index);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildImageSelector(String label, Function onTap, File? image) {
    return GestureDetector(
      onTap: () => onTap(),
      child: DottedBorder(
        strokeWidth: 3,
        color: MyColors.primaryColor(context),
        dashPattern: const [8, 4],
        child: SizedBox(
          width: double.infinity,
          height: image == null ? 250 : 200,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null) ...[
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(image, fit: BoxFit.cover, width: double.infinity, height: 200),
                      IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: _removeMainImage),
                    ],
                  ),
                ] else ...[
                  Icon(Icons.add_a_photo, size: 60.0, color: MyColors.primaryColor(context)),
                  const SizedBox(height: 10),
                  Text(label, style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Edit Product", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 30),
              _buildImageSelector('Choose Main Image', _chooseMainImage, _mainImage),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _chooseSmallImages,
                child: DottedBorder(
                  strokeWidth: 3,
                  color: MyColors.primaryColor(context),
                  dashPattern: const [8, 4],
                  child: const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Text('Choose Additional Images (Max 4)', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _smallImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4.0),
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.primaryColor(context)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.file(_smallImages[index], fit: BoxFit.cover),
                        ),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _removeSmallImage(index)),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_titleController, 'Title', Icons.title),
                    const SizedBox(height: 10),
                    _buildTextField(_descriptionController, 'Description', Icons.description, maxLines: 5),
                    const SizedBox(height: 10),
                    _buildTextField(_priceController, 'Price', Icons.attach_money, keyboardType: TextInputType.number),
                    const SizedBox(height: 10),
                    _buildTextField(_quantityController, 'Quantity', Icons.format_list_numbered, keyboardType: TextInputType.number),
                    const SizedBox(height: 10),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProduct,
                        child: _isLoading ? const CircularProgressIndicator() : const Text('Update Product'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryColor(context))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(),
      ),
      items: _categoryList.map<DropdownMenuItem<String>>((CategoryModel category) {
        return DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      validator: (value) => value == null || value.isEmpty ? 'Please select a category' : null,
    );
  }
}
