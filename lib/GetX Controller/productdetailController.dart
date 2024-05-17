import 'dart:convert';


import 'package:demo_project/Screens/productdetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart%20';

class ProductDetailContoller extends GetxController{
List<dynamic> ProdectDetailList=[].obs;
String imageName='';
String imageUrl='';
var detailLoading=true.obs;
RxString ProductName="".obs;
 RxString productSku = " ".obs;
 RxString productBImage = "".obs;
 RxString productDescription = "".obs;
RxString productPrice= "".obs;



Future<void> getProductImage(String productBImage)async{
  
  String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=image&image=${productBImage}';
  // detailLoading.value = true;
  // _showAlertDialog(context);
  var res=await http.get(Uri.parse(url));
  if(res.statusCode==200){
    final body=res.body;
    final json=jsonDecode(body);
    List data=json['data'];
       detailLoading.value=false;
    print("img url");
    print(data);
    imageUrl=data[0]['msg'];
    // detailLoading.value=false;

 print(detailLoading);
 
  }
}


Future<void> getProductDetail(sku)async{
  detailLoading.value=true;
   Get.to(()=>ProductDetailScreen());
        //  Get.to(()=>ProductDetailScreen());
String url='https://www.texasknife.com/dynamic/texasknifeapi.php?action=product&sku=${sku}';
print(url);
var res=await http.get(Uri.parse(url));
if(res.statusCode==200){
  final body=res.body;
  final json=jsonDecode(body);
  ProdectDetailList=json["data"];
   print("Product Details:");
         print(detailLoading);
  print("product detail list ${ProdectDetailList}");
 String productBImage = ProdectDetailList[0]['product_b_image'];
 ProductName.value=ProdectDetailList[0]['product_name'];
 productSku.value=ProdectDetailList[0]['sku'];
 productDescription.value=ProdectDetailList[0]['description'];
 productPrice.value=ProdectDetailList[0]['product_price'];
      getProductImage(productBImage);
  // Get.to(()=>ProductDetailScreen());
}else {
    print("Failed to fetch product details. Status code: ${res.statusCode}");
  }

}
}