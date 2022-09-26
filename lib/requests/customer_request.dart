import 'package:customers/models/customer_model.dart';
import 'package:customers/helpers/messages.dart';

class CustomerRequest {
  Messages message = Messages();

  createRequest(CustomerModel customerModel, context) {
    if (customerModel.id_reg <= 0) {
      message.errorMessage("El campo region es obligatorio", context);
      return false;
    }

    if (customerModel.id_com <= 0) {
      message.errorMessage("El campo communa es obligatorio", context);
      return false;
    }

    if (customerModel.dni.isEmpty) {
      message.errorMessage("El campo dni es obligatorio", context);
      return false;
    }
    if (customerModel.email.isEmpty) {
      message.errorMessage("El campo email es obligatorio", context);
      return false;
    }
    if (customerModel.name.isEmpty) {
      message.errorMessage("El campo name es obligatorio", context);
      return false;
    }
    if (customerModel.last_name.isEmpty) {
      message.errorMessage("El campo last_name es obligatorio", context);
      return false;
    }
    if (customerModel.address.isEmpty) {
      message.errorMessage("El campo address es obligatorio", context);
      return false;
    }
    return true;
  }
}
