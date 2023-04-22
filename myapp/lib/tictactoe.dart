import 'package:flutter/material.dart';
import 'main.dart';

class TicTacToe extends StatefulWidget {
  final String playerOneName;
  final String playerTwoName;
  const TicTacToe({required this.playerOneName, required this.playerTwoName});

  @override
  // ignore: library_private_types_in_public_api
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  String playerOneName = '';
  String playerTwoName = '';

  int playerOneScore = 0;
  int playerTwoScore = 0;

  bool playerOneTurn = true;

  List<String> gridValues = List.generate(9, (_) => "");

  void initState() {
    super.initState();
    playerOneName = widget.playerOneName;
    playerTwoName = widget.playerTwoName;
  }

  void resetGame() {
    setState(() {
      playerOneScore = 0;
      playerTwoScore = 0;
      playerOneTurn = true;
      gridValues = List.generate(9, (_) => "");
    });
  }

  String checkWinner() {
    //checks to see if someone has won, if so return the string, either: X, O, Tie, or blank
    // check each row
    for (int i = 0; i <= 6; i += 3) {
      if (gridValues[i] != "" &&
          gridValues[i] == gridValues[i + 1] &&
          gridValues[i] == gridValues[i + 2]) {
        return gridValues[i];
      }
    }

    // check each columns
    for (int i = 0; i <= 2; i++) {
      if (gridValues[i] != "" &&
          gridValues[i] == gridValues[i + 3] &&
          gridValues[i] == gridValues[i + 6]) {
        return gridValues[i];
      }
    }

    // check both diagonals
    if (gridValues[0] != "" &&
        gridValues[0] == gridValues[4] &&
        gridValues[0] == gridValues[8]) {
      return gridValues[0];
    }

    if (gridValues[2] != "" &&
        gridValues[2] == gridValues[4] &&
        gridValues[2] == gridValues[6]) {
      return gridValues[2];
    }

    // Check if it's a tie
    if (!gridValues.contains("")) {
      return "Tie";
    }

    // No winner yet
    return "";
  }

  void handleTap(BuildContext context, int index) {
    if (gridValues[index] == "") {
      setState(() {
        gridValues[index] = playerOneTurn ? "X" : "O";
        playerOneTurn = !playerOneTurn;

        String winner = checkWinner();
        if (winner != "") {
          if (winner == "X") {
            playerOneScore += 1;
            gridValues = List.generate(9, (_) => "");
          } else if (winner == "O") {
            playerTwoScore += 1;
            gridValues = List.generate(9, (_) => "");
          }
          if (winner == "X") {
            winner = playerOneName;
          } else if (winner == "O") {
            winner = playerTwoName;
          }
          showDialog(
            context: context,
            builder: (_) => Builder(
              builder: (context) => AlertDialog(
                title: const Text("Game Over"),
                content: Text(winner == "Tie"
                    ? "It's a tie!"
                    : "Congratulations $winner! You are the winner!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        gridValues = List.generate(
                            9, (_) => ""); //reset the grid to blank
                        Navigator.of(context).pop(); // close the dialog
                      });
                    },
                    child: const Text("Play Again"),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tic Tac Toe"),
          backgroundColor: Colors.lightBlue[900],
        ),
        backgroundColor: Colors.blueGrey[900],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        playerOneName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        playerOneScore.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        playerTwoName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        playerTwoScore.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              playerOneTurn ? "$playerOneName's Turn" : "$playerTwoName's Turn",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {
                          handleTap(context, index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.blue,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: gridValues[index] == ''
                                ? Image.asset('assets/white.png',
                                    height: 80, width: 80)
                                : Image.asset('assets/${gridValues[index]}.png',
                                    height: 80, width: 80),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text("Main Menu"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.blue[400],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: resetGame,
                child: Text("Reset Game"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.red[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
