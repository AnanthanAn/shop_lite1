import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplite1/models/Providers/product_provider.dart';
import 'package:shoplite1/models/product.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add-product';
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  var _priceFocusNode = FocusNode();
  var _descFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  var _imageUrlFocusNode = FocusNode();
  var _keyForm = GlobalKey<FormState>();
  var product =Product(id: null, title: null, desc: null, imageUrl: null, price: null);

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  void _updateImage(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {

      });
    }
  }

  void _saveForm(){
    if(!_keyForm.currentState.validate()){
      return;
    }
    _keyForm.currentState.save();
    Provider.of<ProductProvider>(context,listen: false).addProduct(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _keyForm,
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,validator: (value){
                  if(value.isEmpty){
                    return 'Please enter Title';
                  }
                  return null;
              },
                decoration: InputDecoration(labelText: 'Title'),onSaved: (value){
                  product = Product(id: null, title: value, desc: product.desc, imageUrl: product.imageUrl, price: product.price);
              },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter Price';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Price'),onSaved: (value){
                product = Product(id: null, title: product.title, desc: product.desc, imageUrl: product.imageUrl, price: double.parse(value));
              },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
              TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.multiline,validator: (value){
                if(value.isEmpty){
                  return 'Please enter Description';
                }
                return null;
              },
                focusNode: _descFocusNode,onSaved: (value){
                product = Product(id: null, title: product.title, desc: value, imageUrl: product.imageUrl, price: product.price);
              },
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a url')
                        : FittedBox(
                            child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          )),
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: _imageUrlController,validator: (value){
                        if(value.isEmpty){
                          return 'Please enter URl';
                        }
                        return null;
                      },
                    decoration: InputDecoration(labelText: 'Enter URL'),onSaved: (value){
                        product = Product(id: null, title: product.title, desc: product.desc, imageUrl: value, price: product.price);
                      },
                    textInputAction: TextInputAction.done,
                    focusNode: _imageUrlFocusNode,
                  ))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
