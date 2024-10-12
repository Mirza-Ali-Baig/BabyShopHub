import 'package:baby_shop_hub/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/services/category_service.dart';
import '../components/my_appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categories = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _categoryName;
  XFile? _imageFile;
  bool _isLoading = false; // Loading state for all operations
  bool _isDeleting = false; // Loading state for delete operation

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true; // Set loading state for fetching categories
    });

    try {
      var categories = await _categoryService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Handle error
      print('Error fetching categories: $e');
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    _imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _addCategory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Add Category',
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme
                .of(context)
                .primaryColor),
          ),
          content: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Theme
                          .of(context)
                          .primaryColor, width: 2),
                    ),
                    prefixIcon: Icon(Icons.category, color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _categoryName = value;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _selectImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Select Image'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme
                          .of(context)
                          .primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveCategory,
              // Disable button when loading
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme
                    .of(context)
                    .primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true; // Set loading state for adding category
      });

      try {
        await _categoryService.addCategory(
          CategoryModel(
            name: _categoryName!,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          _imageFile!,
        );

        // Reset fields and fetch updated categories
        _categoryName = null; // Resetting the name
        _imageFile = null; // Resetting the image file
        await _fetchCategories();
      } catch (e) {
        // Handle error
        print('Error adding category: $e');
      } finally {
        setState(() {
          _isLoading = false; // Reset loading state
        });
        Navigator.pop(context);
        _formKey.currentState!.reset();
      }
    }
  }

  void _editCategory(int index) {
    _categoryName = _categories[index].name;
    // _imageFile = XFile(_categories[index].image!);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Category'),
          content: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _categoryName,
                  decoration: const InputDecoration(labelText: 'Category Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _categoryName = value;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectImage,
                    child: const Text('Select Image'),
                  ),
                ),
                if (_categories[index].image != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Selected Image: ${_categories[index].image!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _updateCategory(_categories[index].id,_categories[index].image!),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateCategory(String id,String oldImage) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true; // Set loading state for updating category
      });

      try {
        await _categoryService.updateCategory(
          id,
          CategoryModel(
            name: _categoryName!,
            image: oldImage,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          _imageFile,
        );
        await _fetchCategories(); // Refresh the category list
      } catch (e) {
        // Handle error
        print('Error updating category: $e');
      } finally {
        setState(() {
          _isLoading = false; // Reset loading state
        });
        Navigator.pop(context);
        _formKey.currentState!.reset();
      }
    }
  }

  void _deleteCategory(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: _isDeleting
              ? const Center(child: CircularProgressIndicator())
              : const Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: _isDeleting
                  ? null
                  : () async {
                setState(() {
                  _isDeleting = true; // Set loading state for deleting
                });

                try {
                  await _categoryService.deleteCategory(_categories[index].id,_categories[index].image!); // Assuming an appropriate delete method
                  await _fetchCategories(); // Refresh the category list
                } catch (e) {
                  // Handle error
                  print('Error deleting category: $e');
                } finally {
                  setState(() {
                    _isDeleting = false; // Reset loading state
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: _addCategory,
                  icon: const Icon(Icons.add_circle),
                  label: const Text('Add Category'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading // Show loading indicator while fetching categories
                ? const Center(child: CircularProgressIndicator())
                : _categories.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_outlined, size: 80,
                      color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No categories added yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _addCategory,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Add Your First Category'),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          Image.network(
                            _categories[index].image!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: Icon(Icons.image_not_supported, size: 50,
                                    color: Colors.grey[600]),
                              );
                            },
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _categories[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.edit, color: Colors.white),
                                      onPressed: () => _editCategory(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete, color: Colors.white),
                                      onPressed: () => _deleteCategory(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}