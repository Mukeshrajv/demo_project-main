import 'dart:convert';
import 'package:demo_project/GetX%20Controller/loginController.dart';
import 'package:demo_project/GetX Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/shippingControlle.dart';
import 'package:demo_project/Screens/addressScreen.dart';
import 'package:demo_project/Screens/shippingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressData extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final AddressController addressControlle = Get.put(AddressController());
 final ShippingController shippingController = Get.put(ShippingController());
  RxList<dynamic> Datas = <dynamic>[].obs;
  RxList<dynamic> formTwo= <dynamic>[].obs;

//  void _showAlertDialog(BuildContext context) {
//     print("121");
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }

  Future<void> fetchInputAddress(context) async {
    // _showAlertDialog(context);
    String url =
        "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship&bill_name=${addressControlle.AddressDatas[0]['bill_name']}&bill_l_name=${addressControlle.AddressDatas[0]['bill_l_name']}&bill_address1=${addressControlle.AddressDatas[0]['bill_address1']}&bill_address2=${addressControlle.AddressDatas[0]['bill_address2']}&bill_town_city=${addressControlle.AddressDatas[0]['bill_town_city']}&bill_state_region1=${addressControlle.AddressDatas[0]['bill_country']}&bill_zip_code=${addressControlle.AddressDatas[0]['bill_zip_code']}&bill_country=${addressControlle.AddressDatas[0]['bill_country']}&bill_phone=${addressControlle.AddressDatas[0]['bill_phone']}&bill_email1=${addressControlle.AddressDatas[0]['bill_email1']}&customer_id=88985&sessions_id=123456&rurl=&ship_amt=&tx_amount=&check_out_total_amount=&payment_type=&shipment_name=&bill_company=${addressControlle.AddressDatas[0]['bill_company']}";
    print('fetchContinueToPayment: $url');
    //  Get.to(() => ShippingScreen());
    try {
        // _showAlertDialog(context);
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        Datas.assign(json['data'][0]);
        print("Datas");
        print(Datas);
        Get.to(() => ShippingScreen());
      //  shippingController.shipping();
      }
    } catch (e) {
      print('Error in fetchOldAddress: $e');
    }
  }


   Future<void> fetchForm2Address(Address address) async {
    String url =
        "https://www.texasknife.com/dynamic/texasknifeapi.php?action=insert_update_checkoutship&bill_name=${address.firstName}&bill_l_name=${address.lastName}&bill_address1=${address.address}&bill_address2=Majestic Ridge &bill_town_city=${address.city}&bill_state_region1=${address.state}&bill_zip_code=${address.zipCode}&bill_country=${address.country}&bill_phone=${address.phoneNumber}&bill_email1=dev@desss.com&customer_id=88985&sessions_id=123456&rurl=&ship_amt=&tx_amount=&check_out_total_amount=&payment_type=&shipment_name=&bill_company=Desss";
    print('fetchContinueToPayment: $url');
     Get.to(() => ShippingScreen());
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final json = jsonDecode(body);
        Datas.assign(json['data'][0]);
        print("formTwo");
        print(formTwo);
        // Get.to(()=>const ShippingScreen());
      }
    } catch (e) {
      print('Error in fetchOldAddress: $e');
    }
  }
}
