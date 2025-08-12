import 'package:attendence_app/Features/mark_attendance/mark_attendance.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [ Color.fromARGB(255, 44, 109, 161), Color(0xFFFFFFFF)],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *0.15,),
              const Text(
                "Welcome Back,\nLets get you started",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField("Email", false),
              const SizedBox(height: 16),

              _buildTextField("Password", false),
              const SizedBox(height: 16),

          
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: Colors.deepPurple,
                    onChanged: (value) {
                      setState(() => rememberMe = value!);
                    },
                  ),
                   Text("Remember me"),
                ],
              ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkAttendanceView(
                  )));
                    },
                    child:  Text(
                      "Login".toUpperCase(),
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

    Widget _buildTextField(String hint, bool isPassword) {
    return TextField(
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


