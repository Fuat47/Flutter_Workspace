import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

import '../models/product.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.cyanAccent,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child:Icon(Icons.add),
        tooltip: "Add New Product",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("P"),
              ),
              title: Text(this.products[position].name!),
              subtitle: Text(this.products[position].description!),
              onTap:(){goToDetail(this.products[position]);}  ,
            ),
          );
        });
  }

  void goToProductAdd() async {
    var result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAdd()));
    if(result==true){
      setState(() {
        getProducts();

      });

    }
  }
  void getProducts() async{
    var productsFeature=dbHelper.getProducts();
    productsFeature.then((data){
      setState(() {
        products=data;
        productCount=data.length;
      });

    });
  }

  void goToDetail(Product product) async {
    var result=await Navigator.push(context,  MaterialPageRoute(builder: (context)=>ProductDetail(product)));;



    if(result==true){
      getProducts();
    }
    }
}
