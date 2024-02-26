import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HangmanGame(),
    );
  }
}

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  final List<String> qwertyKeyboardCharacters = [
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
    'Z', 'X', 'C', 'V', 'B', 'N', 'M'
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
    final Map<String, String> selectedWord = words[_random.nextInt(words.length)];
    hiddenWord = selectedWord.keys.first;
    displayedWord = '*' * hiddenWord.length;
    wordHint = selectedWord.values.first;
  }

  void checkGameStatus() {
  if (chancesLeft <= 0) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SecondeHome(victory: false),
      ),
    );
  } else if (displayedWord == hiddenWord) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SecondeHome(victory: true),
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
    setState(() {
      chancesLeft = 5;
      gameOver = false;
      selectRandomWord();
    });
  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Chances restantes : $chancesLeft',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
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

class SecondeHome extends StatelessWidget {
  final bool victory;
  // final VoidCallback gameState; 

  SecondeHome({required this.victory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              victory ? 'Vous avez gagné!' : 'Vous avez perdu!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // gameState(); // Appelez resetGame() ici
                Navigator.pop(context); // Retour à la route précédente
              },
              child: Text('Rejwe'),
            ),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Kite'),
            ),
          ],
        ),
      ),
    );
  }
}

























// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Hangman',
//       theme:
//           ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
//       home: const MyHomePage(title: 'Hangman'),
//     );
//   }
// }



// class MyHomePage extends StatefulWidget {
//   final String title;

//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomepageState();
// }

// class _MyHomepageState extends State<MyHomePage> {
//   int score = 5;


// Map<String, String> hidenWord = {
//     'Li se Kapital Ayiti': 'Potoprens',
//     'yo konsiderel kom pi gwo lkol infomatik': 'ESIH',
//     'Li se ban repiblik Ayiti': 'BRH',
//     'Li se bank nasyonl Kredi': 'BNC',
//   };

//   final Random random = Random();
//   String kleChwazi = hidenWord.keys.elementAt(random.nextInt(hidenWord.length));

  
//   void decrementScore() {
//     setState(() {
//       score = score--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               widget.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   '$score',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 31,
//                   ),
//                 ),
//                 SizedBox(width: 4.0),
//                 Icon(
//                   Icons.star,
//                   color: Color(0xFFFFD700),
//                   size: 30,
//                 ),
//                 SizedBox(width: 10.0),
//               ],
//             ),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text(
//                 'Hangman',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//                 title: Text("Rejwe"),
//                 onTap: () {
//                   print('Rejwe');
//                   Navigator.pop(context);
//                 }),
//             ListTile(
//                 title: Text("Ed"),
//                 onTap: () {
//                   print('Ed');
//                   Navigator.pop(context);
//                 }),
//             ListTile(
//                 title: Text("kite"),
//                 onTap: () {
//                   print('kite');
//                   Navigator.pop(context);
//                 }),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//               padding: EdgeInsets.only(
//                   top:
//                       MediaQuery.of(context).padding.top + kToolbarHeight + 5)),
//           Text(
//             '*************',
//             style: TextStyle(
//               fontSize: 60,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'sa se text par defaut a',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 2),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 color: Colors.grey[300],
//                 child: MyVirtualKeyboard(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyVirtualKeyboard extends StatelessWidget {
//   final List<String> keyboardCharacters = [
//     'q',
//     'w',
//     'e',
//     'r',
//     't',
//     'y',
//     'u',
//     'i',
//     'o',
//     'p',
//     'a',
//     's',
//     'd',
//     'f',
//     'g',
//     'h',
//     'j',
//     'k',
//     'l',
//     'z',
//     'x',
//     'c',
//     'v',
//     'b',
//     'n',
//     'm',
//     '<-)'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 9,
//         mainAxisSpacing: 1.0,
//         crossAxisSpacing: 1.0,
//       ),
//       itemCount: keyboardCharacters.length,
//       itemBuilder: (context, index) {
//         return ElevatedButton(
//           onPressed: () {
//             print(keyboardCharacters[index]);
//           },
//           child: Text(
//             keyboardCharacters[index],
//             style: TextStyle(fontSize: 18),
//           ),
//         );
//       },
//     );
//   }
// }

// class SecondeHome extends StatelessWidget {
//   const SecondeHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Genyen/Pedi',
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   print('Rejwe');
//                 },
//                 child: Text('Rejwe'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   print('Kite');
//                 },
//                 child: Text('Kite'),
//               ),
//             ],
//           )
//         ],
//       )),
//     );
//   }
// }
