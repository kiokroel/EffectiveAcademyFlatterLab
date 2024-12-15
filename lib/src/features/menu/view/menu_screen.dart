import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/product.dart';
import 'package:flutter_course/src/features/menu/view/product_card.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();

  List<String> categories = [
    'Черный кофе',
    'Кофе с молоком',
    'Чай',
    'Авторские напитки',
  ];

  List<List<Product>> products = [
    [Product('Олеато', 130, 'assets/images/i.webp'), Product('Олеато', 130, 'assets/images/i.webp')],
    [Product('Олеато', 130, 'assets/images/i.webp'), Product('Олеато', 130, 'assets/images/i.webp')],
    [Product('Олеато', 130, 'assets/images/i.webp'), Product('Олеато', 130, 'assets/images/i.webp')],
    [Product('Олеато', 130, 'assets/images/i.webp'), Product('Олеато', 130, 'assets/images/i.webp')],
  ];

  int activeCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _updateActiveCategory();
    });
  }

  void _updateActiveCategory() {
    for (int i = 0; i < categories.length; i++) {
      if (_scrollController.position.pixels >= (i * 120) &&
          _scrollController.position.pixels < (i + 1) * 120) {
        setState(() {
          activeCategoryIndex = i;
        });
        break;
      }
    }
  }

  void _scrollToCategory(int index) {
    _scrollController.animateTo(
      index * 120.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _categoryScrollController.animateTo(
      index * 100.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                controller: _categoryScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _scrollToCategory(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(categories[index]),
                        backgroundColor: activeCategoryIndex == index
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          categories[index],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true, 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: products[index].length,
                        itemBuilder: (context, productIndex) {
                          return ProductCard(product: products[index][productIndex]);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
