import 'package:customers/models/commune_model.dart';
import 'package:customers/models/region_model.dart';
import 'package:customers/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:customers/helpers/text_input.dart';
import 'package:customers/controllers/region_controller.dart';
import 'package:customers/controllers/customer_controller.dart';
import 'package:customers/helpers/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerCreate extends StatefulWidget {
  const CustomerCreate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerCreate();
  }
}

class _CustomerCreate extends State<CustomerCreate> {
  late SharedPreferences prefs;
  final regionController = RegionController();
  late List<DropdownMenuItem> regions = [];
  late List<DropdownMenuItem> communes = [];
  bool isLoading = false;
  Messages messages = Messages();
  @override
  void initState() {
    super.initState();
    isLoading = true;
    regionController.index().then((value) {
      setState(
        () {
          for (int i = 0; i < value.length; i++) {
            regions.add(DropdownMenuItem(
              value: value[i].id,
              child: Text(value[i].description),
            ));
          }
          isLoading = false;
        },
      );
    });
    cargarPrefs();
  }

  cargarPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('id_region', 0);
    prefs.setInt('id_communa', 0);
  }

  @override
  Widget build(BuildContext context) {
    final dni = TextEditingController();
    //dni.text = "QJKHRTERIOP";
    final email = TextEditingController();
    //email.text = "gatho@mail.com";
    final name = TextEditingController();
    //name.text = "Mayla";
    final lastName = TextEditingController();
    //lastName.text = "Maylusca";
    final address = TextEditingController();
    //address.text = "Casa del perro #32 Col. Guau";

    CustomerController customerController = CustomerController();
    CustomerModel customerModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create customer."),
        actions: [
          IconButton(
              onPressed: () {
                customerModel = CustomerModel(
                    prefs.getInt('id_region')!.toInt(),
                    prefs.getInt('id_communa')!.toInt(),
                    dni.text,
                    name.text,
                    name.text,
                    lastName.text,
                    address.text);

                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                Widget continueButton = TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    customerController.create(customerModel, context);
                    Navigator.pop(context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                );
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text("Save information?"),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              icon: const Icon(Icons.save_outlined)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            child: ListView(
              children: [
                Container(
                  // Region Input
                  padding:
                      const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
                  child: DropdownButtonFormField(
                    style: const TextStyle(
                      fontSize: 15.0,
                      //fontFamily: "Lato",
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFe5e5e5),
                        border: InputBorder.none,
                        hintText: "Region",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)))),
                    items: regions,
                    onChanged: (id_region) {
                      prefs.setInt('id_region', id_region);
                      regionController
                          .loadCommunesByRegion(id_region)
                          .then((value) {
                        setState(() {
                          isLoading = true;
                          for (int i = 0; i < value.length; i++) {
                            //print(value[i]);
                            communes.add(DropdownMenuItem(
                              value: value[i].id,
                              child: Text(value[i].description),
                            ));
                          }
                          isLoading = false;
                        });
                      });
                    },
                  ),
                ),
                Container(
                  // Communa Imput
                  padding:
                      const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
                  child: DropdownButtonFormField(
                    style: const TextStyle(
                      fontSize: 15.0,
                      //fontFamily: "Lato",
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFe5e5e5),
                        border: InputBorder.none,
                        hintText: "Communa",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)))),
                    items: communes,
                    onChanged: (id_communa) {
                      prefs.setInt('id_communa', id_communa);
                    },
                  ),
                ),
                TextInput("DNI", TextInputType.text, dni, 1, false),
                TextInput("Email", TextInputType.emailAddress, email, 1, false),
                TextInput("Name", TextInputType.text, name, 1, false),
                TextInput("Last name", TextInputType.text, lastName, 1, false),
                TextInput(
                    "Address", TextInputType.multiline, address, 3, false),
              ],
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
