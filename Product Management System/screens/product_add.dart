import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper=DbHelper();
  var txtName=TextEditingController();
  var txtDescription=TextEditingController();
  var txtUnitPrice=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Description"),
      controller: txtDescription,
    );
  }

  buildPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Price"),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return TextButton(
        child: Text("Add"),

        onPressed: (){
          addProduct();
        },
    );
  }

  addProduct() async {
    await dbHelper.insert(Product(txtName.text,txtDescription.text,double.tryParse(txtUnitPrice.text)!));
    Navigator.pop(context,true);

  }
}
