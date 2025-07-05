import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF414345)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.hourglass_top_rounded,
                size: 100,
                color: Colors.amber,
              ),
              const SizedBox(height: 30),
              Text(
                'يرجى الانتظار',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.95),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'جاري معالجة طلبك...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              // const CircularProgressIndicator(
              //   // valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              //   strokeWidth: 6,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
