import 'package:flutter/material.dart';

import 'package:flutter_course/src/features/menu/view/product.dart';


class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.product.imagePath),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Text(widget.product.name),
          if (quantity == 0)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  quantity = 1;
                });
              },
              child: Text('${widget.product.price.toStringAsFixed(2)} руб'),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 0) {
                        quantity--;
                      }
                    });
                  },
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (quantity < 10) {
                        quantity++;
                      }
                    });
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
