import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: double.infinity,
      width: double.infinity,
      color:Color.fromARGB(255, 230, 240, 241).withOpacity(0.5), // Semi-transparent black color
      child:const Center(
        child: CircularProgressIndicator(
          //  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //  backgroundColor: Colors.grey,
           semanticsLabel: 'Loading',
        ), 
      // Loading indicator
      ),
    );
  }
}
