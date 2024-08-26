import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/functions/generate_unique_id.dart';
import 'package:inventory_management_app/models/customer_model.dart';

// ignore: constant_identifier_names
const CUSTOMER_BOX = 'CustomerBox';

//Opened a box for item so we can use it any time
late Box<CustomerModel> customerBox;

Future<void> getAllCustomersFormDB() async {
  customerBox = await Hive.openBox<CustomerModel>(CUSTOMER_BOX);
  customerListNotifier.value.clear();
  customerListNotifier.value =
      customerBox.values.cast<CustomerModel>().toList();
  // customerBox.clear();
  notifyCustomers();
  print(
      'fetching all customers from database\nThe number of customer in the DB is ${customerBox.values.length}');
}

Future<void> addCustomerToDB(CustomerModel customer) async {
  customerBox = await Hive.openBox<CustomerModel>(CUSTOMER_BOX);
  //todo:put unique id

  int id = generateUniqueId();
  customer.customerId = id;
  await customerBox.put(id, customer);
  print(
      'A new customer is added to database and the customer id = $id and the length of all customer is ${customerBox.values.length}');
  for (var val in customerBox.values) {
    print(val.customerName);
  }
  getAllCustomersFormDB();
}

Future<void> deleteCustomerFromDB(int customerId) async {
  customerBox = await Hive.openBox<CustomerModel>(CUSTOMER_BOX);
  customerBox.delete(customerId);
  getAllCustomersFormDB();
  print(
      'The customer in the id = $customerId is deleted and the length of all customers is ${customerBox.values.length}');
}

void notifyCustomers() {
  customerListNotifier.notifyListeners();
}
