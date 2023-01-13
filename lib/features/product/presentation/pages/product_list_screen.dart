// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/features/product/presentation/bloc/product_bloc.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X10 Shop'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return Text(state.toString());
        } else if (state is GetProductStateSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.products[index].name ?? ""),
                subtitle: Text('ราคาสินค้า ${state.products[index].price} บาท' ),
                leading: Image.network(state.products[index].image?? ""),
              );
            },
            itemCount: state.products.length,
          );
        }

        return Container();
      }, listener: (context, state) {
        if (state is ProductError) {
          print(state);
        }
      }),
    );
  }
}
