import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if(selectedValue == FilterOptions.Favorites) {
                _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'), 
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'), 
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart> (
                builder: (_, cart, child) =>
                  Badge(
                    child: child,
                    value: cart.itemCount.toString(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                  ),
              ),
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}

