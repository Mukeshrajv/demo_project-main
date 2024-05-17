import 'package:demo_project/GetX%20Controller/homeController.dart';
import 'package:demo_project/GetX%20Controller/productdetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubSubCategoryPage extends StatefulWidget {
  const SubSubCategoryPage({Key? key}) : super(key: key);

  @override
  _SubSubCategoryPageState createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage> {
  final HomeContoller homeController = Get.put(HomeContoller());
  final ProductDetailContoller productDetailController =
      Get.put(ProductDetailContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: subSubCategoryWidget(
        //           context, homeController, productDetailController)
          child: Obx(
          () {
            if (homeController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return
               subSubCategoryWidget(
                  context, homeController, productDetailController);
            }
          },
        ),
      ),
    );
  }
}

Widget subSubCategoryWidget(BuildContext context, HomeContoller homeController,
    ProductDetailContoller productDetailController) {
  return Container(
    child: Obx(
      () => ListView.builder(
        itemCount: homeController.subSubCategoryData.length,
        itemBuilder: (context, index) {
          final itemsList = homeController.subSubCategoryData[index];
          // if(homeController.subSubCategoryData.length==0){
          //   return Center(child:
          //    CircularProgressIndicator());
          // }else{
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemsList.length,
            itemBuilder: (context, itemIndex) {
              final item = itemsList[itemIndex];
              return InkWell(
                onTap: () {
                  productDetailController.getProductDetail(item["sku"]);
                },
                child: Container(
                  color: const Color.fromARGB(255, 178, 217, 248),
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.14,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * 0.12,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: item["product_image"] != null
                            ? FutureBuilder(
                                future: precacheImage(
                                    NetworkImage(item["product_image"]), 
                                    context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Image.network(
                                      item["product_image"],
                                       scale: 1.0, 
                                      fit: BoxFit.fill,
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            : Center(child: Text('No image')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              height:
                                  MediaQuery.of(context).size.height * 0.06,
                              child: Text(
                                item["product_name"] ?? '',
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            ),
                            Text("\$${item["product_price"] ?? ''}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          //  }
        },
      ),
    ),
  );
}
