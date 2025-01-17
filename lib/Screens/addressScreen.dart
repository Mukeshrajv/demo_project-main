import 'package:demo_project/GetX%20Controller/addressControlle.dart';
import 'package:demo_project/GetX%20Controller/addressData.dart';
import 'package:demo_project/Screens/shippingScreen.dart';
import 'package:demo_project/Screens/cartScreen.dart';
import 'package:demo_project/Screens/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class Address {
  String firstName;
  String lastName;
  String address;
  String city;
  String country;
  String state;
  String zipCode;
  String phoneNumber;

  Address({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.country,
    required this.state,
    required this.zipCode,
    required this.phoneNumber,
  });
}

class addressScreen extends StatefulWidget {
  const addressScreen({super.key});

  @override
  State<addressScreen> createState() => _addressScreenState();
}

class _addressScreenState extends State<addressScreen> {
  String? userName;
  String? email;
  int? _selectedValue = 1;
  final AddressData addressData = Get.put(AddressData());
  final AddressController addressController=Get.put(AddressController());
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final List<TextEditingController> _textControllers =
      List.generate(17, (_) => TextEditingController());

  final AddressController addressControlle = Get.find();
  

  void submitForm() async {
  
    if (_selectedValue == 1) {
      if (_formKey1.currentState != null) {
        if (_formKey1.currentState!.validate()) {
          print('form1');
          print('Email: ${addressControlle.AddressDatas[0]['bill_email1']}');

           addressData.fetchInputAddress(context);
    
   
        }
      } else {
        print('Form state is null for form 1');
      }
    } else if (_selectedValue == 2) {
      if (_formKey2.currentState != null) {
        if (_formKey2.currentState!.validate()) {
          print('form2');
          print('First Name: ${_textControllers[0].text}');
          Address address = Address(
            firstName: _textControllers[0].text,
            lastName: _textControllers[1].text,
            address: _textControllers[2].text,
            city: _textControllers[3].text,
            country: _textControllers[4].text,
            state: _textControllers[5].text,
            zipCode: _textControllers[6].text,
            phoneNumber: _textControllers[7].text,
          );
          print('text:${address}');
          print('text:${address.firstName}');
          addressData.fetchForm2Address(address);
          Get.to(() => const ShippingScreen());
        }
      } else {
        print('Form state is null for form 2');
      }
    }
  }

  void _showLoaderAndNavigateBack(){
     showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return LoadingOverlay();
            },
          );
           Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Address"),
          leading: IconButton(
  icon: Icon(Icons.arrow_back), // Wrap the icon with Icon widget
  onPressed: () {
    Get.to(() => CartScreeen());
  },
),

          centerTitle: true,
        ),
        body:
        
         Form(
          child: SafeArea(
            child: Obx(() => addressControlle.addressLoading.value ?
                  Center(child: CircularProgressIndicator()) 
            : 
               Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: _selectedValue == 1,
                            child: Form(
                              key: _formKey1,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:  EdgeInsets.all(8.0),
                                      child:  Text("Contact Information",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_email1']}",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Email';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Email"),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Shipping Address',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              initialValue:
                                                  "${addressControlle.AddressDatas[0]['bill_name']}",
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your name';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "FirstName"),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              initialValue:
                                                  "${addressControlle.AddressDatas[0]['bill_l_name']}",
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your name';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "LastName"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_company']}",
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Company(optional)"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_address1']}",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Address"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_address2']}",
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText:
                                                "Apartment,Suite,Etc(optional)"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_town_city']}",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter city';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "city"),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              initialValue:
                                                  "${addressControlle.AddressDatas[0]['bill_country']}",
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Country/Region';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Country/Region"),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: TextFormField(
                                              initialValue:
                                                  "${addressControlle.AddressDatas[0]['bill_state_region1']}",
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter State';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "State"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_zip_code']}",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter ZipCode';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "ZipCode"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            "${addressControlle.AddressDatas[0]['bill_phone']}",
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter PhoneNumber';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "PhoneNumber"),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Billing Address',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    'Select The Address That Matches Your Cards Or Payment method',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                              RadioMenuButton(
                                  value: 1,
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                  child: const Text('Same As Shipping',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(117, 78, 13, 231)))),
                              const Divider(
                                color: Colors.black,
                                thickness: 1.0,
                                height: 20.0,
                                indent: 20.0,
                                endIndent: 20.0,
                              ),
                              RadioMenuButton(
                                  value: 2,
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                  child: const Text('Use a Different',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(117, 78, 13, 231)))),
                            ],
                          ),
                          Visibility(
                            visible: _selectedValue == 2,
                            child: Form(
                              key: _formKey2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Billing Address',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          // key: _formKey2,
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _textControllers[0],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter LastName';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "FirstName",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: _textControllers[1],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter FirstName';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "LastName"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Company(optional)"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textControllers[2],
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Address"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              "Apartment,Suite,Etc(optional)"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textControllers[3],
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "city"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter city';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: _textControllers[4],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter Country/Region ';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Country/Region"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: _textControllers[5],
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "State"),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter State';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textControllers[6],
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "ZipCode"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter ZipCode';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: _textControllers[7],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "PhoneNumber"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter PhoneNumber';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextButton(
                          onPressed: submitForm,
                          child: Text("Continue to Shipping"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
