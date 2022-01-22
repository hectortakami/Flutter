// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:firebase_forms/models/product.dart';
import 'package:firebase_forms/providers/firebase_provider.dart';
import 'package:firebase_forms/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    return firebaseProvider.isLoading ? const LoadingWidget() : ProductList();
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    final formProvider = Provider.of<ProductFormProvider>(context);
    final List<ProductModel> products = firebaseProvider.productList;

    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formProvider.isNewProduct = true;
          formProvider.product = ProductModel(
            available: true,
            name: null,
            price: null,
            picture: null,
          ).copy();
          Navigator.pushNamed(context, 'detail');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);

    return GestureDetector(
      onTap: () {
        formProvider.isNewProduct = false;
        formProvider.product = product.copy();
        Navigator.pushNamed(context, 'detail');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Hero(
                tag: product.id != null ? product.id! : UniqueKey(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: validateImageType(product.picture),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [0, 1.0],
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.name != null ? product.name! : '',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.grey[300]),
                    ),
                    Text(
                      product.price != null
                          ? '\$${product.price!.toStringAsFixed(2)}'
                          : '\$0.00',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.grey[300]),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
              availableTag(!product.available)
            ],
          ),
        ),
      ),
    );
  }

  Widget validateImageType(String? picture) {
    if (picture == null) {
      return const FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      );
    }
    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/loading.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      );
    } else {
      final file = File.fromUri(Uri(path: picture));
      return Image.file(
        file,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      );
    }
  }

  availableTag(bool isOutOfStock) {
    if (isOutOfStock) {
      return const Positioned(
          top: 15,
          left: 15,
          child: Chip(
            label: Text(
              'Out of stock',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.indigo,
          ));
    }
    return Container();
  }
}
