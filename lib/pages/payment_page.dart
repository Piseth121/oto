import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';
import '../models/payment_model.dart';
import '../widgets/add_credit_card.dart';

class PaymentPage extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navigate and wait for new card to be added
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddCreditCardPage()),
              );

              if (result != null && result is PaymentMethod) {
                controller.addPaymentMethod(result);
              }
            },
          )
        ],
      ),
      body: Obx(() {
        final methods = controller.paymentMethods;
        if (methods.isEmpty) {
          return Center(child: Text('No payment methods added.'));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Payment Methods',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final method = methods[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.credit_card),
                      title: Text('${method.cardHolderName}'),
                      subtitle: Text('${method.cardNumber}  |  Exp: ${method.expiryDate}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () async {
                              final updatedCard = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddCreditCardPage(existingCard: method),
                                ),
                              );
                              if (updatedCard != null && updatedCard is PaymentMethod) {
                                controller.editPaymentMethod(updatedCard);
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.deletePaymentMethod(method.id),
                          ),
                        ],
                      ),
                      selected: controller.selectedMethodId.value == method.id,
                      onTap: () => controller.selectPaymentMethod(method.id),
                    ),
                  );
                },
              ),
              // Other payment methods section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Payment Methods:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 24,
                          child: Image.asset('assets/icons/visa_card.png'),
                        ),
                        title: Text('Credit/Debit Card'),
                        onTap: () async {
                          // Navigate and wait for new card to be added
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AddCreditCardPage()),
                          );

                          if (result != null && result is PaymentMethod) {
                            controller.addPaymentMethod(result);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 24,
                          child: Image.asset('assets/icons/aba.png'),
                        ),
                        title: Text('ABA'),
                        onTap: () {
                          // Handle other payment method selection
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 24,
                          child: Image.asset('assets/icons/ac.png'),
                        ),
                        title: Text('ACELIDA'),
                        onTap: () {
                          // Handle other payment method selection
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
