import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/controllers/cart_controller.dart';
import 'package:otokhi/pages/payment_page.dart';
import '../constant_model/top_selling.dart';
import 'add_bank_acc.dart';
import 'add_credit_card.dart';
import '../pages/address_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.put(CartController());
  final _formKey = GlobalKey<FormState>();
  int _selectedValue = 1;
  Map<String, dynamic>? selectedAddress;
  bool isAddressSelected = false;

  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Product Name 1', 'price': 20.0, 'quantity': 2},
    {'name': 'Product Name 2', 'price': 50.0, 'quantity': 1},
    {'name': 'Product Name 3', 'price': 15.0, 'quantity': 1},
  ];

  String name = '';
  String address = '';
  String cardNumber = '';

  double get total {
    return topselling.fold(
      0,
      (sum, item) => sum + (item.prices * item.quantity.toDouble()),
    );
  }

  void placeOrder() {
    if (!isAddressSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a shipping address')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Order Placed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thank you, ${selectedAddress!['name']}!'),
              SizedBox(height: 8),
              Text('Shipping to:'),
              Text('${selectedAddress!['street']}, ${selectedAddress!['city']}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Text('Order total: ',
                   ),
                   SizedBox(width: 8),
                  Text('\$${total.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.red)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _handlePaymentMethodChange(int? value) {
    if (value == null) return;

    setState(() {
      _selectedValue = value;
    });

    // Navigate based on selection
    if (value == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddCreditCardPage()),
      );
    } else if (value == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddBankAcc()),
      );
    } else if (value == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddBankAcc()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // In your CheckoutPage's build method, update the shipping address section:
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  isAddressSelected
                      ? Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [

                              Text(
                                selectedAddress!['name'] ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(selectedAddress!['phone'] ?? ''),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${selectedAddress!['street'] ?? ''}, ${selectedAddress!['city'] ?? ''}, ${selectedAddress!['zip'] ?? ''}',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isAddressSelected)
                                TextButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AddressesPage()),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        selectedAddress = result;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Change Address',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressesPage()),
                      );
                      if (result != null) {
                        setState(() {
                          selectedAddress = result;
                          isAddressSelected = true;
                        });
                      }
                    },
                    child: Text('Select Shipping Address'),
                  ),
                ],
              ),
            ),
            Divider(),
            Text(
              'Cart Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...cartController.cartItems.map(
              (item) => ListTile(
                leading: Image.asset(item.image, width:50, height: 50, fit: BoxFit.cover),
                title: Text('${item.name} (x${item.quantity})'),
                trailing: Text(
                  '\$${(item.prices * item.quantity.toDouble()).toStringAsFixed(2)}',
                ),
              ),
            ),
            Divider(),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Payment Methods', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Radio<int>(
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(),
                            ),
                          );
                        });
                      },
                    ),
                    title: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/visa_card.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Card'),
                      ],
                    ),
                    onTap: () => _handlePaymentMethodChange(1),
                  ),
                  ListTile(
                    leading: Radio<int>(
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBankAcc(),
                            ),
                          );
                        });
                      },
                    ),
                    title: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/aba.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('ABA'),
                      ],
                    ),
                    onTap: () => _handlePaymentMethodChange(2),
                  ),
                  ListTile(
                    leading: Radio<int>(
                      value: 3,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBankAcc(),
                            ),
                          );
                        });
                      },
                    ),
                    title: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/ac.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('ACELIDA'),
                      ],
                    ),
                    onTap: () => _handlePaymentMethodChange(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: placeOrder,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: Text(
            'Place Order',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
