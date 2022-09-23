import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpinner extends StatelessWidget {
  String message = "";
  CustomSpinner(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitSpinningLines(
      size: 200.0,
      lineWidth: 5.0,
      itemCount: 10,
      color: Colors.blue,
    );
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            margin: const EdgeInsets.only(top: 100.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
              image: const DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/customer_logo_katze.png'),
              ),
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 10.0), child: spinkit),
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 22.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
