import 'package:flutter/material.dart';

  bool rememberMe = false;
  bool isPasswordVisible = false;

class AddShopsView extends StatefulWidget {
  const AddShopsView({super.key});

  @override
  State<AddShopsView> createState() =>
      _AddShopsViewState();
}

class _AddShopsViewState
    extends State<AddShopsView> {
  final _formKey = GlobalKey<FormState>();
  final _shopMame = TextEditingController();
  final _ownerName = TextEditingController();
  final _contactNumber = TextEditingController();
  final _sddress = TextEditingController();

  final Color primaryBlue = const Color(0xFF5D6EFF);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
   
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *0.05,),
              const Text(
                "Add Shops",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField("Shop Name", false,1),
              const SizedBox(height: 16),

  
               _buildTextField("Owner Name", false,1),
              const SizedBox(height: 16),

                _buildTextField("Contact Number", false,1),
              const SizedBox(height: 16),
               _buildTextField("Address", false,3),

              const SizedBox(height: 16),

        
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *0.38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                 
                    },
                    child:  Text(
                      "Add Shop".toUpperCase(),
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),


            ],
          ),
        ),
      ),
    );
    
  
  }

  
    Widget _buildTextField(String hint, bool isPassword,int maxlines) {
    return TextField(
      maxLines: maxlines,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        
        hintText: hint,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
