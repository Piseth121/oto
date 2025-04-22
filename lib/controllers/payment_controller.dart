
import 'package:get/get.dart';

import '../models/payment_model.dart';

class PaymentController extends GetxController {
  var paymentMethods = <PaymentMethod>[
    PaymentMethod(
      id: '1',
      cardNumber: '**** **** **** 1234',
      cardHolderName: 'John Doe',
      expiryDate: '12/24',
    ),
    PaymentMethod(
      id: '2',
      cardNumber: '**** **** **** 5678',
      cardHolderName: 'Jane Smith',
      expiryDate: '11/25',
    ),
  ].obs;

  var selectedMethodId = ''.obs;

  void selectPaymentMethod(String id) {
    selectedMethodId.value = id;
  }

  void addPaymentMethod(PaymentMethod method) {
    paymentMethods.add(method);
  }
  void editPaymentMethod(PaymentMethod updatedMethod) {
    int index = paymentMethods.indexWhere((m) => m.id == updatedMethod.id);
    if (index != -1) {
      paymentMethods[index] = updatedMethod;
      paymentMethods.refresh(); // Important to update UI
    }
  }


  void deletePaymentMethod(String id) {
    paymentMethods.removeWhere((method) => method.id == id);
    Get.snackbar('Success', 'Payment method deleted.');
  }


}
