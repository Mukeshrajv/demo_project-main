import 'package:demo_project/GetX%20Controller/cartController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:demo_project/Screens/tabNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailContoller productDetailContoller =
      Get.put(ProductDetailContoller());
  final CartController cartController = Get.put(CartController());

  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Obx(
          () => productDetailContoller.detailLoading.value
              ? 
             Center(
      child:Container(
        height: double.infinity,
      width: double.infinity,
      color:Color.fromARGB(255, 230, 240, 241).withOpacity(0.5), // Semi-transparent black color
      child:const Center(
        child: CircularProgressIndicator(
          //  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //  backgroundColor: Colors.grey,
           semanticsLabel: 'Loading',
        ), 
      )
      )
     )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        productDetailContoller.imageUrl,
                        scale: 1.0, // Ensure scale is set here if needed
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 170, 168, 167),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                productQuantity++;
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                          Text('$productQuantity'),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (productQuantity > 1) {
                                                  productQuantity--;
                                                }
                                              });
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Get.dialog( const AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 20),
                                            Text("Adding to Cart..."),
                                          ],
                                        ),
                                      ));
                                      cartController.getAddToCart(
                                        productDetailContoller
                                            .ProdectDetailList[0]['id']
                                            .toString(),
                                        productQuantity,
                                        productDetailContoller
                                            .ProdectDetailList[0]['sku']
                                            .toString(),
                                        productDetailContoller
                                            .ProdectDetailList[0]
                                                ['product_price']
                                            .toString(),
                                        context,
                                      ).then((_) {
                                        Get.back();
                                      Get.snackbar(
                                        'Added to Cart',
                                        ' successfully added to cart',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 2),
                                      );
                                       Get.offAll(TabNavigation());
                                      });
                                    },
                                    icon: const Icon(Icons.add_shopping_cart),
                                    label: const Text("Add To Cart"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "${productDetailContoller.ProductName} ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "${productDetailContoller.productSku}"),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Price :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                      "${productDetailContoller.productPrice}"),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${productDetailContoller.productDescription.toString().replaceAll(RegExp(r'<[^>]*>|<\/[^>]*>'), '')},",
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        )));
  }
}
