import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

//--------------------------------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HangmanGame(),
    );
  }
}



//--------------------------------------------------------------------------------------
class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}


//--------------------------------------------------------------------------------------------------------
class _HangmanGameState extends State<HangmanGame> {
  final List<String> qwertyKeyboardCharacters = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M'
  ];
  final List<Map<String, String>> words = [
    {'HELLO': 'Greeting'},
    {'WORLD': 'Planet Earth'},
    {'FLUTTER': 'Framework'},
    {'DEVELOPER': 'Programmer'},
  ];

  final _random = Random();
  late String hiddenWord;
  late String displayedWord;
  late String wordHint;
  int chancesLeft = 5;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    selectRandomWord();
  }

  void selectRandomWord() {
    final Map<String, String> selectedWord =
        words[_random.nextInt(words.length)];
    hiddenWord = selectedWord.keys.first;
    displayedWord = '*' * hiddenWord.length;
    wordHint = selectedWord.values.first;
  }

  void checkGameStatus() {
    if (chancesLeft <= 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondeHome(
            victory: false,
            onResetGame: resetGame, 
          ),
        ),
      );
    } else if (displayedWord == hiddenWord) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondeHome(
            victory: true,
            onResetGame: resetGame, 
          ),
        ),
      );
    }
  }

  void checkLetter(String letter) {
    setState(() {
      if (!gameOver) {
        letter = letter.toUpperCase();
        if (hiddenWord.contains(letter)) {
          for (int i = 0; i < hiddenWord.length; i++) {
            if (hiddenWord[i] == letter) {
              displayedWord = displayedWord.replaceRange(i, i + 1, letter);
            }
          }
        } else {
          chancesLeft--;
        }
      }
      checkGameStatus();
    });
  }

  void resetGame() {
    if (mounted) {
      setState(() {
        chancesLeft = 5;
        gameOver = false;
        selectRandomWord();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hangman',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Text(
                  '$chancesLeft',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                  ),
                ),
                SizedBox(width: 4.0),
                Icon(
                  Icons.star,
                  color: Color(0xFFFFD700),
                  size: 30,
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Hangman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
                title: Text("Rejwe"),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HangmanGame(),
                    ),
                  );

                  print('Rejwe');
                }),
            ListTile(
                title: Text("Ed"),
                onTap: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HelpPage(), 
                    ),
                  );
                  print('Ed');
                  // Navigator.pop(context);
                }),
            ListTile(
                title: Text("kite"),
                onTap: () {
                  print('kite');
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayedWord,
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            Text(
              'Indice : $wordHint',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: qwertyKeyboardCharacters.map((letter) {
                return ElevatedButton(
                  onPressed: gameOver ? null : () => checkLetter(letter),
                  child: Text(letter),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


//--------------------------------------------------------------------------------
class SecondeHome extends StatelessWidget {
  final bool victory;
  final VoidCallback onResetGame;

  SecondeHome({required this.victory, required this.onResetGame});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            victory ? 'Ou gnyn!' : 'Ou pedi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  onResetGame(); 
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HangmanGame(),
                    ),
                  );
                },
                child: Text('Rejwe'),
              ),
              ElevatedButton(
                onPressed: () {
                  // exit(0);
                  Navigator.pop(context);
                },
                child: Text('Kite'),
              ),
            ],
          )
        ],
      )),
    );
  }
}


//-------------------------------------------------------------
class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Epiyayyyy ou pansew tap vin bon sou nou la ',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                
              },
              child: Text('Retounen'),
            ),
          ],
        ),
      ),
    );
  }
}
