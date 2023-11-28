import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _errorText = '';
  Timer? _timer;
  bool _loading = false;

  @override
  void dispose() {
    _timer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple, Colors.blue],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/perfil.png'),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _errorText = '';
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _emailController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _errorText = '';
                  });
                },
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 350,
              child: Text(
                _errorText,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _loading ? null : () async {
                String name = _nameController.text;
                String email = _emailController.text;


               if (name.isEmpty) {
                  _displayError('Usuario es requerido');
                } else if (email.isEmpty) {
                  _displayError('Contraseña es requerida');
                } else {
                   setState(() {
                  _loading = true; 
                });

                var headers = {'Content-Type': 'application/json'};
                var request = http.Request(
                    'POST',
                    Uri.parse(
                        'https://transporte-el2a.onrender.com/api/vendedor/login'));
                request.body =
                    json.encode({"usuario": name, "contrasena": email});
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  print(await response.stream.bytesToString());
                  _displaySuccess('Login Exitoso');
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>  const MyExampleCard(),
                    ),
                  );
                } else if (response.statusCode == 400) {
                  _displayError('Usuario/contraseña incorrectos');
                } else if (response.statusCode == 401) {
                  _displayError('Usuario/contraseña incorrectos');
                } else {
                  print(response.reasonPhrase);
                }

                setState(() {
                  _loading = false; 
                });
                }

               
              },
              child: _loading
                  ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

void _displayError(String errorMessage) {
  setState(() {
    _errorText = errorMessage;
  });

  _timer = Timer(const Duration(seconds: 4), () {
    if (mounted) {
      // Verifica si el widget está todavía en el árbol de widgets
      setState(() {
        _errorText = '';
      });
    }
  });
}



  void _displaySuccess(String successMessage) {
    setState(() {
      _errorText = successMessage;
    });

    _timer = Timer(const Duration(seconds: 4), () {
      setState(() {
        _errorText = '';
      });
    });
  }
}
