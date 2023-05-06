import 'package:flutter/material.dart';
// model import
import 'package:lists_logic/models/products.dart';

void main() => runApp(const MyApp());

// creating a new variable to store the Product models info using typedef
// it acts like a pointer in dart to store the functional data
typedef CartChangedCallback = Function(Product product, bool isInCart);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List\'s'),
          centerTitle: true,
          backgroundColor: Colors.red[400],
        ),
        body: const ShoppingLists(
          products: [
            Product(name: 'Wake up at 6 AM'),
            Product(name: 'Bring Groceries'),
            Product(name: 'Business Meeting'),
            Product(name: 'Walk my dog'),
            Product(name: 'Office Work'),
            Product(name: 'Client Meeting'),
            Product(name: 'Code Review'),
            Product(name: 'Exercise'),
            Product(name: 'Dating App'),
            Product(name: 'Whatsapp'),
            Product(name: 'Instagram'),
            Product(name: 'Facebook'),
            Product(name: 'Twitter'),
            Product(name: 'App Code'),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(
      {required this.product,
      required this.isInCart,
      required this.cartChanged})
      : super(key: ObjectKey(product));

  // creating variables
  final Product product;
  final bool isInCart;
  final CartChangedCallback cartChanged;

  // -- change the listtile color when tapped --
  Color changeColor(BuildContext context) {
    return isInCart ? Colors.black : Colors.blue;
  }

  // -- Change the liststyle title text style when tapped. --
  // TextStyle is declared as a null function
  TextStyle? changeTextStyle(BuildContext context) {
    // if item is not selected
    if (!isInCart) {
      return const TextStyle(
        color: Colors.blue,
        fontSize: 22,
      );
    }
    // if item is selected / tapped change the text style, add a line-through.
    return const TextStyle(
      color: Colors.red,
      fontSize: 17,
      decoration: TextDecoration.lineThrough,
    );
  }

  // Change the background color of the list when tapped. 
  BoxDecoration? changeBoxDecoration(BuildContext context) {
    if (!isInCart) {
      return BoxDecoration(
        color: Colors.blue[50],
      );
    }
    return BoxDecoration(
      color: Colors.red[50],
    );
  }

  void listTilePressed() {
    cartChanged(product, isInCart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 0,
            ),
            // Here we wrapped Container inside ListTile to enable background color changes.
            child: Container(
              decoration: changeBoxDecoration(context),
              child: ListTile(
                onTap: listTilePressed,
                leading: CircleAvatar(
                  backgroundColor: changeColor(context),
                  // display the first letter of name
                  child: Text(product.name[0]),
                ),
                title: Text(
                  product.name,
                  style: changeTextStyle(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingLists extends StatefulWidget {
  const ShoppingLists({super.key, required this.products});

  // create a final lists of products
  // inititlizing a new variable
  final List<Product> products;

  @override
  State<ShoppingLists> createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingLists> {
  // creatae an empty shopping cart list
  // we can add shopping items afterwards
  final shoppingCartItems = <Product>{};

  void handleCartChanges(Product product, bool isInCart) {
    setState(() {
      if (!isInCart) {
        shoppingCartItems.add(product);
      } else {
        shoppingCartItems.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We are using ListView because we want scrollable lists.
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((product) {
          return ListItem(
            product: product,
            isInCart: shoppingCartItems.contains(product),
            cartChanged: handleCartChanges,
          );
        }).toList(),
      ),
    );
  }
}
