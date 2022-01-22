// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:firebase_forms/providers/firebase_provider.dart';
import 'package:firebase_forms/providers/form_provider.dart';
import 'package:firebase_forms/providers/image_picker_provider.dart';
import 'package:firebase_forms/shared/utils/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    final firebaseProvider = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        //automaticallyImplyLeading: false, // Removes auto created back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_rounded),
            onPressed: () async {
              final imagePath = await ImagePickerProvider().selectFromGallery();
              if (imagePath == null) {
                formProvider.isPictureChanged = false;
                return;
              } else {
                formProvider.productPicture = imagePath;
                formProvider.isPictureChanged = true;
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 100),
            ProductImage(
              provider: formProvider,
            ),
            ProductFields(
              provider: formProvider,
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          backgroundColor: Colors.indigo,
          onPressed: () async {
            if (formProvider.isNewProduct) {
              firebaseProvider.createProduct(formProvider.product);
            } else {
              if (formProvider.isPictureChanged &&
                  formProvider.product.picture != null) {
                final cloudinaryPath = await ImagePickerProvider()
                    .uploadToCloudinary(formProvider.product.picture!);
                formProvider.product.picture = cloudinaryPath;
                formProvider.isPictureChanged = false;
              }
              firebaseProvider.updateProduct(formProvider.product);
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ProductImage extends StatelessWidget {
  final ProductFormProvider provider;

  const ProductImage({
    required this.provider,
  });
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: provider.product.id != null ? provider.product.id! : UniqueKey(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: validateImageType(provider.product.picture),
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
}

class ProductFields extends StatelessWidget {
  final ProductFormProvider provider;

  const ProductFields({
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: provider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        const SizedBox(height: 25),
        TextFormField(
          initialValue: provider.product.name,
          decoration: CustomInputDecorations.customInputDecoration(
            hintText: 'Nike Air Max 95',
            labelText: 'Product Name',
            iconName: Icons.sell,
          ),
          onChanged: (value) => provider.product.name = value,
          validator: (value) =>
              (value != null && value.isNotEmpty && value.length <= 16)
                  ? null
                  : 'Empty name or max characters reached (16)',
        ),
        const SizedBox(height: 15),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
          ],
          initialValue: provider.product.price != null
              ? '${provider.product.price}'
              : null,
          decoration: CustomInputDecorations.customInputDecoration(
            hintText: '\$299.00',
            labelText: 'Price',
            iconName: Icons.paid,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              provider.product.price = double.tryParse(value)!;
            }
          },
          validator: (value) => (value!.isNotEmpty) ? null : 'Not valid amount',
        ),
        const SizedBox(height: 15),
        SwitchListTile.adaptive(
          value: provider.product.available,
          title: Text(
            'Available',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onChanged: (value) => provider.productAvailability = value,
          activeColor: Colors.indigo,
        )
      ]),
    );
  }
}
