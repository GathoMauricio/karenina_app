import 'package:customers/helpers/messages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:customers/models/customer_model.dart';
import 'package:customers/controllers/custommer_controller.dart';
import 'package:customers/controllers/user_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomerIndex extends StatefulWidget {
  const CustomerIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerIndex();
  }
}

class _CustomerIndex extends State<CustomerIndex> {
  //Objeto controlador de customers
  final customerController = CustomerController();
  //lista de customers
  late List<CustomerModel> customers = [];
  //flag loading
  bool isLoading = false;
  //Objetos de mensajes
  Messages messages = Messages();
  @override
  void initState() {
    super.initState();
    isLoading = true;
    customerController.index(context).then((value) => {
          setState(
            () {
              customers.addAll(value);
              isLoading = false;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
        actions: [
          IconButton(
              onPressed: () => UserController().logout(context),
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Column(
        children: [
          isLoading
              ? messages.loadingIndicator("Obteniendo registros...", context)
              : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                  ),
                  child: Text(customers[index].name),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
