import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorbin/controller/products_provider.dart';
import 'package:tutorbin/utils/mediaquery.dart';
import 'package:tutorbin/utils/snackbar.dart';

class Products extends StatefulWidget {
  const Products({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getProducts();
    super.initState();
  }

  final Resize _resize = Resize();
  @override
  Widget build(BuildContext context) {
    _resize.setValue(
        context); //initalizing the mediaquery once in the app to reuse them over al the app
    return Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider myData, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title: Text(widget.title),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (myData.totalMoney != 0) {
              myData.buyProducts();
              showSnackBarGreen('Items has been purchased', context);
            } else {
              showSnackBarRed('Please add Items into Cart', context);
            }
          },
          child: Container(
              height: _resize.resposiveConst * 60,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                'Place Order ₹${myData.totalMoney}',
                style: const TextStyle(color: Colors.white),
              )),
        ),
        body: Container(
          child: myData.products == null
              ? const CircularProgressIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: myData.products!.length,
                  itemBuilder: ((context, index) {
                    var key = myData.products!.keys.elementAt(index);
                    return ListTileTheme(
                      dense: true,
                      child: ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                key.toString(),
                                style: TextStyle(
                                    fontSize: _resize.resposiveConst * 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87.withOpacity(0.8)),
                              ),
                              Text(
                                key.length.toString(),
                                style: TextStyle(
                                    fontSize: _resize.resposiveConst * 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87.withOpacity(0.8)),
                              ),
                            ],
                          ),
                          expandedAlignment: Alignment.topLeft,
                          childrenPadding: const EdgeInsets.only(
                            left: 40,
                          ),
                          children: [
                            ...myData.products![key].asMap().entries.map((e) {
                              return ListTile(
                                title: Text(
                                  e.value['name'].toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      e.value['price'].toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    e.value['bestseller'] != null &&
                                            e.value['bestseller']
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.red),
                                            child: const Text(
                                              'Best Selling',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                trailing: e.value['bought'] != null &&
                                        e.value['bought'] > 0
                                    ? SizedBox(
                                        width: _resize.width * 0.24,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                myData.removeProducts(
                                                    e.value['price'],
                                                    key,
                                                    e.key);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow[700],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40),
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow[700],
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 3.5),
                                                child: Text(
                                                  e.value['bought'].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                myData.addProducts(
                                                    e.value['price'],
                                                    key,
                                                    e.key);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow[700],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ],
                                        ))
                                    : GestureDetector(
                                        onTap: () {
                                          myData.addProducts(
                                              e.value['price'], key, e.key);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.yellow[700],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                              );
                            }).toList()
                          ]),
                    );
                  })),
        ),
      );
    });
  }
}
