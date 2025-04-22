
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/payment_model.dart';


class AddCreditCardPage extends StatefulWidget {
  final PaymentMethod? existingCard;
  const AddCreditCardPage({super.key, this.existingCard});

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingCard != null) {
      _nameController.text = widget.existingCard!.cardHolderName;
      _expiryDateController.text = widget.existingCard!.expiryDate;
      // You can't decrypt a masked card number, so assume they re-enter it
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Credit Card'),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Cardholder Name',
                icon: Icons.person,
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              _buildTextField(
                controller: _cardNumberController,
                label: 'Card Number',
                icon: Icons.credit_card,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (val) => val!.length < 16 ? 'Invalid card number' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      label: 'Expiry Date (MM/YY)',
                      icon: Icons.date_range,
                      keyboardType: TextInputType.datetime,
                      validator: (val) => val!.isEmpty ? 'Enter expiry' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _cvvController,
                      label: 'CVV',
                      icon: Icons.lock,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      validator: (val) => val!.length != 3 ? 'Invalid CVV' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newCard = PaymentMethod(
                      id: widget.existingCard?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      cardNumber: '**** **** **** ${_cardNumberController.text.substring(_cardNumberController.text.length - 4)}',
                      cardHolderName: _nameController.text,
                      expiryDate: _expiryDateController.text,
                    );
                    Navigator.pop(context, newCard);
                  }
                }
,
                icon: Icon(Icons.save,color: Colors.white),
                label: Text('Save Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
