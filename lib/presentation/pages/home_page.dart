import 'package:flutter/material.dart';
import 'package:flutter_application_6/presentation/pages/house_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Test Task'),
              SizedBox(
                  width: 200,
                  height: 200,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffD9D9D9),
                      ),
                      child: Image.asset('lib/assets/image.png'))),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: const Text('Enter '),
              )
            ],
          ),
        ),
      ),
    );
  }
}
