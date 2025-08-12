import 'package:attendence_app/Features/home/home_view.dart';
import 'package:attendence_app/Features/mark_attendance/mark_attendance.dart';
import 'package:flutter/material.dart';

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

              // Name
              _buildTextField("Email", false),
              const SizedBox(height: 16),

              // Email
              _buildTextField("Password", false),
              const SizedBox(height: 16),

              // Password
              // _buildTextField("Create password", true),
              // const SizedBox(height: 12),

              // Remember me
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

              // Create account button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *0.40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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



// class SignInScreen extends StatelessWidget {
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final ValueNotifier<bool> _obscureText = ValueNotifier(true);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,        
//             left: 0,
//             right: 0,      
//             child: ClipPath( 
//               clipper: WavyClipper(),
//               child: Container(
//                 height: 250,
//                 color: Colors.grey[100],
//                 child: SizedBox(
//                   child: Image.asset("assets/logo_3_optimized.png",height: 30,width: 30
//                   ),
//                 ),
//               ),
//             ),
//           ),


//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: ClipPath(
//               clipper: BottomWaveClipper(),
//               child: Container(
//                 height: 210,
//                  color: Colors.grey[100],
//                // color: Colors.blue.shade700,
//               ),
//             ),
//           ),

//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Material(
//                 elevation: 0,//8
//                 borderRadius: BorderRadius.circular(16),
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   width: 320,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "SIGN IN",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         controller: mobileController,
//                         decoration: const InputDecoration(
//                           labelText: "Email",
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       ValueListenableBuilder(
//                         valueListenable: _obscureText,
//                         builder: (context, value, _) {
//                           return TextField(
//                             controller: passwordController,
//                             obscureText: value,
//                             decoration: InputDecoration(
//                               labelText: "Password",
//                               border: const OutlineInputBorder(),
//                               suffixIcon: IconButton(
//                                 icon: Icon(value
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   _obscureText.value = !value;
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 8),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {},
//                           child: const Text(
//                             "Forgot Password?",
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       // ElevatedButton(
//                       //   onPressed: () {},
//                       //   style: ElevatedButton.styleFrom(
//                       //     backgroundColor: Colors.blue,
//                       //     minimumSize: const Size(double.infinity, 40),
//                       //     shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(8),
//                       //     ),
//                       //   ),
//                       //   child: const Text("START"),
//                       // ),
//                       const SizedBox(height: 8),
//                       OutlinedButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkAttendanceView()));
//                         },
//                         style: OutlinedButton.styleFrom(
//                           minimumSize:  Size(150, 40),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text("SIGN IN"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SemiCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     path.lineTo(0, size.height - 80);
//     path.arcToPoint(
//       Offset(size.width, size.height - 80),
//       radius: Radius.circular(100),
//       clockwise: false,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


// class WavyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 40);

//     path.quadraticBezierTo(
//       size.width / 4, size.height,
//       size.width / 2, size.height - 40,
//     );

//     path.quadraticBezierTo(
//       3 * size.width / 4, size.height - 80,
//       size.width, size.height - 40,
//     );

//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


// // Custom Clipper for top design
// class TopWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 80);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height - 100);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }


// class BottomWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 100);
//     path.quadraticBezierTo(
//         size.width / 2, 0, size.width, 80);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
