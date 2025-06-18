import 'package:flutter/material.dart';


void main() {
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Simple Login App',
     home: LoginPage(),
   );
 }
}
class LoginPage extends StatefulWidget {
 @override
 _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Login'),
       backgroundColor: Colors.blue,
     ),
     body: Padding(
       padding: EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           // Welcome Text
           Text(
             'Welcome!',
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.bold,
             ),
           ),
           SizedBox(height: 30),
           // Email Field
           TextField(
             controller: _emailController,
             decoration: InputDecoration(
               labelText: 'Email',
               border: OutlineInputBorder(),
             ),
           ),
           SizedBox(height: 20),
           // Password Field
           TextField(
             controller: _passwordController,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Password',
               border: OutlineInputBorder(),
             ),
           ),
           SizedBox(height: 30),
           // Login Button
           ElevatedButton(
             onPressed: () {
               _handleLogin();
             },
             child: Text('Login'),
           ),
           SizedBox(height: 20),
           // Sign Up Text
           Text("Don't have an account? Sign Up"),
         ],
       ),
     ),
   );
 }
 void _handleLogin() {
   String email = _emailController.text;
   String password = _passwordController.text;


   if (email.isEmpty || password.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please fill in all fields')),
     );
   } else {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Login successful!')),
     );
   }
 }
}
