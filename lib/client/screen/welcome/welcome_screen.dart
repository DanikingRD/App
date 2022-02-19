import 'package:digital_card_app/client/screen/auth/auth_screen.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  
  final AuthService _service; 

  const WelcomeScreen(this._service, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const linearGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 204, 41, 54),
        Color.fromARGB(255, 216, 81, 92),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.height,
          decoration: const BoxDecoration(gradient: linearGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/image/logo.png'),
              const SizedBox(height: 15),
              const Text(
                'Tapea',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 250,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                  ),
                  child: const Text('GET STARTED', style: TextStyle(color: Colors.red, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AuthScreen(_service, linearGradient);
                  }));
                },
                child: const Text('LOG IN WITH EXISTING ACCOUNT', style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}