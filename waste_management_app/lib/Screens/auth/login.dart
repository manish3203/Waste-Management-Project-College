import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_managemet_app/Screens/auth/forgot_password.dart';
import 'package:waste_managemet_app/Screens/auth/sign_up.dart';
import 'package:waste_managemet_app/Screens/dashboard_home_about%20page/home_page.dart';


// Import your home page file here

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations here
    super.dispose();
  }

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // Navigate to the home page after successful login
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful', style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(31, 185, 4, 1)
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()), // Navigate to your home page
      );
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password',style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(192, 4, 4, 1),
        ),
      );
      print('Error signing in: $e');
      // Handle sign-in errors, show feedback to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Welcome to",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5da646),
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "EcoHarbor",
                style: TextStyle(
                    fontFamily: "Lato",
                    color: Color(0xff1d2d47),
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Email",
                style: TextStyle(
                    fontFamily: "Sans Serif Collection",
                    fontSize: 16,
                    color: Color(0x7f1d2d47)),
              ),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Enter Email', prefixIcon: Icon(Icons.email)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(
                    fontFamily: "Sans Serif Collection",
                    fontSize: 16,
                    color: Color(0x7f1d2d47)),
              ),
              TextField(
                controller: password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    hintText: 'Enter Password', prefixIcon: Icon(Icons.lock)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(93, 166, 70, 1),
                    minimumSize: const Size(280, 50),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
                      'Register Now',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
