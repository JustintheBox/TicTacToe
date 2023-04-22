import 'package:flutter/material.dart';
import 'tictactoe.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _playerOneController = TextEditingController();
  TextEditingController _playerTwoController = TextEditingController();

  @override
  void dispose() {
    _playerOneController.dispose();
    _playerTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.lightBlue[900],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/mindtapp.png"),
              const Text(
                'Tic Tac Toe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 70),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: _playerOneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Player 1 Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: _playerTwoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Player 2 Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 90),
              SizedBox(
                width: 230.0,
                height: 70.0,
                child: ElevatedButton(
                  child: const Text(
                    'Start Game',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 38,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicTacToe(
                                playerOneName: _playerOneController.text,
                                playerTwoName: _playerTwoController.text,
                              )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
