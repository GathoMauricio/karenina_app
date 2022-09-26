import 'package:customers/helpers/messages.dart';
import 'package:customers/views/customer/customer_create.dart';
import 'package:flutter/material.dart';
import 'package:customers/models/customer_model.dart';
import 'package:customers/controllers/customer_controller.dart';
import 'package:customers/controllers/user_controller.dart';

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Text(
                          "${customers[index].name} ${customers[index].last_name}",
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CustomerCreate())))
              .then((value) {
            if (customers.isNotEmpty) {
              customers.clear();
            }

            setState(() {
              isLoading = true;
            });

            customerController.index(context).then((value) => {
                  setState(
                    () {
                      customers.addAll(value);
                      isLoading = false;
                    },
                  )
                });
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
