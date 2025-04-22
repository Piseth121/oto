
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBankAcc extends StatefulWidget {
  const AddBankAcc({super.key});

  @override
  State<AddBankAcc> createState() => _AddBankAccState();
}

class _AddBankAccState extends State<AddBankAcc> {
  final _formKey = GlobalKey<FormState>();

  final _bankNameController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Bank Account'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _bankNameController,
                label: 'Bank Name',
                icon: Icons.account_balance,
                validator: (val) => val!.isEmpty ? 'Enter bank name' : null,
              ),
              _buildTextField(
                controller: _accountHolderController,
                label: 'Account Holder Name',
                icon: Icons.person,
                validator: (val) => val!.isEmpty ? 'Enter account holder name' : null,
              ),
              _buildTextField(
                controller: _accountNumberController,
                label: 'Account Number',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (val) => val!.length < 8 ? 'Invalid account number' : null,
              ),
              _buildTextField(
                controller: _ifscController,
                label: 'IFSC / SWIFT Code',
                icon: Icons.code,
                textCapitalization: TextCapitalization.characters,
                validator: (val) => val!.isEmpty ? 'Enter IFSC or SWIFT code' : null,
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save bank logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bank Account Saved')),
                    );
                  }
                },
                icon: Icon(Icons.save,color: Colors.white,),
                label: Text('Save Account',style: TextStyle(color: Colors.white,fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
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
    TextCapitalization textCapitalization = TextCapitalization.none,
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
        textCapitalization: textCapitalization,
        validator: validator,
      ),
    );
  }
}
