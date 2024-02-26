import 'package:flutter/material.dart'; // Enpòte libreri Flutter

// Importasyon an reprezante enpòtasyon de bibliyotèk yo pou itilizasyon nan aplikasyon Flutter.

import 'dart:math'; // Enpòte bibliyotèk Random nan Dart.

import 'package:flutter/services.dart'; // Enpòte bibliyotèk yo ki an rapò ak sèvis nan sistèm nan (pa itilize nan kòd la).

void main() {
  runApp(MyApp()); // Fonksyon main pou lanse aplikasyon an.
}

//--------------------------------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Anpèch mode debouche afiche nan banè an.
      home: HangmanGame(), // Fè aplikasyon an kòmanse ak HangmanGame kòm paj prensipal.
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
  final List<String> qwertyKeyboardCharacters = [ // List ki gen karakter klavye QWERTY la.
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G',
    'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M'
  ];

   final List<Map<String, String>> words = [
    {'HELLO': 'Greeting'},
    {'WORLD': 'Planet Earth'},
    {'FLUTTER': 'Framework'},
    {'DEVELOPER': 'Programmer'},
  ];
  final _random = Random(); // Enstans Random pou jere chwa mo aleatwa.

  late String hiddenWord; // Mo kache.
  late String displayedWord; // Mo afiche.
  late String wordHint; // Endis mo a.
  int chancesLeft = 5; // Chans ki rete jwè a.
  bool gameOver = false; // Si jwè a fini jwèt la.

  @override
  void initState() { // Fonksyon pou enisyalize jwè a.
    super.initState();
    selectRandomWord(); // Chwazi yon mo aleatwa lè jwè a kòmanse.
  }

  void selectRandomWord() { // Fonksyon pou chwazi yon mo aleatwa nan list la.
    final Map<String, String> selectedWord = words[_random.nextInt(words.length)];
    hiddenWord = selectedWord.keys.first;
    displayedWord = '*' * hiddenWord.length;
    wordHint = selectedWord.values.first;
  }

  void checkGameStatus() { // Fonksyon pou tcheke estati jwèt la.
    if (chancesLeft <= 0) { // Si pa gen plis chans.
      Navigator.pushReplacement( // Fè yon chanjman nan pwochen paj la.
        context,
        MaterialPageRoute(
          builder: (context) => SecondeHome(
            victory: false,
            onResetGame: resetGame, // Pase fonksyon resetGame la.
          ),
        ),
      );
    } else if (displayedWord == hiddenWord) { // Si jwè a genyen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondeHome(
            victory: true,
            onResetGame: resetGame, // Pase fonksyon resetGame la.
          ),
        ),
      );
    }
  }

  void checkLetter(String letter) { // Fonksyon pou tcheke lèt ki chwazi.
    setState(() {
      if (!gameOver) { // Si jwè a poko fini jwèt la.
        letter = letter.toUpperCase(); // Konvèti lèt la nan let majiskil.
        if (hiddenWord.contains(letter)) { // Si mo a gen lèt la.
          for (int i = 0; i < hiddenWord.length; i++) {
            if (hiddenWord[i] == letter) {
              displayedWord = displayedWord.replaceRange(i, i + 1, letter); // Retele lèt la sou mo a.
            }
          }
        } else {
          chancesLeft--; // Diminye chans la.
        }
      }
      checkGameStatus(); // Tcheke si jwè a genyen oswa pa.
    });
  }

  void resetGame() { // Fonksyon pou rekòmanse jwèt la.
    if (mounted) {
      setState(() {
        chancesLeft = 5;
        gameOver = false;
        selectRandomWord(); // Chwazi yon mo aleatwa.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Banè aplikasyon an.
        backgroundColor: Colors.blue, // Koulè banè a.
        title: Row( // Lij tit ak kantite chans ki rete.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hangman', // Tit aplikasyon an.
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Text(
                  '$chancesLeft', // Kantite chans ki rete.
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                  ),
                ),
                SizedBox(width: 4.0),
                Icon(
                  Icons.star, // Ikòn pou endike chans.
                  color: Color(0xFFFFD700), // Koulè etwal la.
                  size: 30,
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer( // Meni bouchon.
        child: ListView( // Lis eleman nan meni a.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader( // Banè meni a.
              child: Text(
                'Hangman', // Tit meni a.
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // Koulè banè meni a.
              ),
            ),
            ListTile( // Eleman nan meni a.
              title: Text("Jwe Ankò"), // Tex pou rekòmanse jwèt la ankò.
              onTap: () { // Lè w klike sou li.
                Navigator.pushReplacement( // Fè yon chanjman nan paj la.
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HangmanGame(), // Relanse jwèt la.
                  ),
                );
              },
            ),
            ListTile( // Eleman nan meni a.
              title: Text("Ed"), // Tex pou jwèt la.
              onTap: () { // Lè w klike sou li.
                Navigator.pushReplacement( // Fè yon chanjman nan paj la.
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HelpPage(), // Paj Ed.
                  ),
                );
              },
            ),
            ListTile( // Eleman nan meni a.
              title: Text("Kite"), // Tex pou kite aplikasyon an.
              onTap: () { // Lè w klike sou li.
                Navigator.pop(context); // Fè meni a disparèt.
              },
            ),
          ],
        ),
      ),
      body: Center( // Ko a jwèt la.
        child: Column( // Kòlòn eleman yo.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( // Mo a afiche.
              displayedWord,
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            Text( // Endis mo a.
              'Endis : $wordHint',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Wrap( // Pakèt pou bouton klavye yo.
              spacing: 10,
              runSpacing: 10,
              children: qwertyKeyboardCharacters.map((letter) { // Boucle sou chak karakter nan lis la.
                return ElevatedButton( // Bouton eleve.
                  onPressed: gameOver ? null : () => checkLetter(letter), // Fonksyon klike.
                  child: Text(letter), // Lèt afiche sou bouton an.
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
  final bool victory; // Si jwè a genyen oswa pa.
  final VoidCallback onResetGame; // Fonksyon pou rekòmanse jwèt la.

  SecondeHome({required this.victory, required this.onResetGame});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Ko a jwèt la.
      body: Center(
          child: Column( // Kòlòn eleman yo.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text( // Mesaj ki di si jwè a genyen oswa pèdi.
            victory ? 'Ou genyen!' : 'Ou pèdi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row( // Lij bouton pou rekòmanse jwèt la oswa kite li.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton( // Bouton eleve.
                onPressed: () {
                  onResetGame(); // Fonksyon pou rekòmanse jwèt la.
                  Navigator.pushReplacement( // Fè yon chanjman nan paj la.
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HangmanGame(), // Relanse jwèt la.
                    ),
                  );
                },
                child: Text('Jwe Ankò'), // Tex sou bouton an.
              ),
              ElevatedButton( // Bouton eleve.
                onPressed: () {
                  Navigator.pop(context); // Fè meni a disparèt.
                },
                child: Text('Kite'), // Tex sou bouton an.
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
    return Scaffold( // Ko a jwèt la.
      body: Center(
        child: Column( // Kòlòn eleman yo.
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text( // Mesaj pou jwè a.
              'Epiyayyyy ou pansew tap vin bon sou nou la ',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton( // Bouton eleve.
              onPressed: () {
                Navigator.pop(context); // Fè meni a disparèt.
              },
              child: Text('Retounen'), // Tex sou bouton an.
            ),
          ],
        ),
      ),
    );
  }
}
