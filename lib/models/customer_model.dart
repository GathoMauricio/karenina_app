// ignore_for_file: non_constant_identifier_names
class CustomerModel {
  late int id;
  late int id_reg;
  late int id_com;
  late String dni;
  late String email;
  late String name;
  late String last_name;
  late String address;
  late String date_reg;
  late String status;
  late String created_at;
  late String updated_at;

  CustomerModel(this.id_reg, this.id_com, this.dni, this.email, this.name,
      this.last_name, this.address);
  /*
  CustomerModel.fromJson(<Map <String, dynamic> json>) {
    id = json['id'];
  }
  */
}
