import 'package:flutter/material.dart';
import 'package:petitparser/context.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

var icons = Icons.cancel;
// to make icon X and O visible
var is_tapped = false;
// the ui will rerender so keeping record of individual box
dynamic area = [
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
  {"is_tapped": is_tapped, "icons": icons},
];

var win_game_sequence = [
  "012",
  "345",
  "678",
  '036',
  "147",
  "258",
  "048",
  "246"
];

// to keep sequence of palyer's tapped
var player_1_tapped = [];
var player_2_tapped = [];

// to knwo which player is playing
int player_no = 1;

// to say game is draw or not
int tap_count = 0;
// to show message who has win
var who_will_win = "";

// to do nothing when game is over
var play_again = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tic Tac Toe"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ChoosePlayer(),
            // PlayGround(),
            // play ground
            Expanded(
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Stack(children: [
                        GestureDetector(
                          onTap: () {
                            // do this till game draw
                            if (play_again == false) {
                              tap_count++;
                              // to show icon
                              area[index]["is_tapped"] = true;

                              if (player_no == 1) {
                                player_1_tapped.add(index);
                                player_no = 2;
                                area[index]['icons'] = Icons.cancel;
                              } else {
                                player_2_tapped.add(index);
                                player_no = 1;
                                area[index]['icons'] = Icons.circle_outlined;
                              }

                              // checking all the game sequence on the player tapped list

                              if (player_1_tapped.length >= 3) {
                                var player_1 = player_1_tapped.join("");
                                bool result = false;

                                label:
                                for (int i = 0;
                                    i < win_game_sequence.length;
                                    i++) {
                                  for (int j = 0; j < 3; j++) {
                                    result = player_1
                                        .contains(win_game_sequence[i][j]);
                                    if (!result) {
                                      break;
                                    }
                                  }

                                  // if result is true game win happen

                                  if (result) {
                                    break label;
                                  } else {
                                    continue;
                                  }
                                }

                                if (result) {
                                  play_again = true;
                                  who_will_win = "Player X win";
                                  setState(() {
                                    
                                  });
                                  return;
                                }
                                else if(tap_count == 9){
                                play_again = true;
                                who_will_win = "Draw";
                                setState(() {
                                    
                                  });
                                return;
                                }
                              }

                              if (player_2_tapped.length >= 3) {
                                var player_2 = player_2_tapped.join("");
                                bool result = false;

                                label:
                                for (int i = 0;
                                    i < win_game_sequence.length;
                                    i++) {
                                  for (int j = 0; j < 3; j++) {
                                    result = player_2
                                        .contains(win_game_sequence[i][j]);
                                    if (!result) {
                                      break;
                                    }
                                  }

                                  if (result) {
                                    break label;
                                  } else {
                                    continue;
                                  }
                                }

                                if (result) {
                                  play_again = true;
                                  who_will_win = "Player O win";
                                  setState(() {
                                    
                                  });
                                  return;
                                }
                                else if(tap_count == 9){
                                play_again = true;
                                who_will_win = "Draw";
                                setState(() {
                                    
                                  });
                                return;
                                }
                              }

                              setState(() {});
                            }
                          },
                          child: Container(
                            width: 130,
                            height: 130,
                            color: Colors.red,
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity:
                                  // showing icon which is pressed
                                  (area[index]['is_tapped'] == true ? 1 : 0),
                              child: Icon(
                                area[index]['icons'],
                                size: 90,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    })),

            // play ground

            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(
                who_will_win,
                style: TextStyle(fontSize: 25),
              ),
            ),

            // play again

            (play_again)
                ? Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        reset_all();
                        setState(() {});
                      },
                      child: Text(
                        "Play Again",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                : Text("")

            // play again ends
          ],
        ));
  }
}

void reset_all() {
  is_tapped = false;
  icons = Icons.cancel;
  area = [
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
    {"is_tapped": is_tapped, "icons": icons},
  ];

  player_1_tapped = [];
  player_2_tapped = [];
  player_no = 1;
  tap_count = 0;
  who_will_win = "";
  play_again = false;
}

// class PlayAgain extends StatefulWidget {
//   const PlayAgain({super.key});

//   @override
//   State<PlayAgain> createState() => _PlayAgainState();
// }

// class _PlayAgainState extends State<PlayAgain> {
//   void reset_all() {
//     is_tapped = false;
//     icons = Icons.cancel;
//     area = [
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//       {"is_tapped": is_tapped, "icons": icons},
//     ];

//     player_1_tapped = [];
//     player_2_tapped = [];
//     player_no = 1;
//     tap_count = 0;
//     who_will_win = "";
//     play_again = false;

//     setState(() {

//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 50),
//       child: ElevatedButton(
//         onPressed: () {
//           reset_all();
//         },
//         child: Text(
//           "Play Again",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class ChoosePlayer extends StatelessWidget {
  const ChoosePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    icons = Icons.cancel;
                    player_no = 1;
                  },
                  child: Text("Player X", style: TextStyle(fontSize: 20)))),
          SizedBox(
            width: 20,
          ),
          SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    icons = Icons.circle_outlined;
                    player_no = 2;
                  },
                  child: Text("Player O", style: TextStyle(fontSize: 20)))),
        ],
      ),
    );
  }
}


// class PlayGround extends StatefulWidget {
//   @override
//   State<PlayGround> createState() => _PlayGroundState();
// }

// class _PlayGroundState extends State<PlayGround> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: GridView.builder(
//             itemCount: 9,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
//             itemBuilder: (context, index) {
//               return Stack(children: [
//                 GestureDetector(
//                   onTap: () {
//                     tap_count++;
//                     if(tap_count == 9){
//                       who_will_win = "Draw";
//                       setState(() {
                        
//                       });
//                       return;
                      
//                     }

//                     if(player_no == 1){
//                       player_1_tapped.add(index);
//                       player_no = 2;
//                       area[index]['icons'] = Icons.cancel;

//                     }
//                     else{
//                       player_2_tapped.add(index);
//                       player_no = 1;
//                       area[index]['icons'] = Icons.circle_outlined;
//                     }

//                     if(player_1_tapped.length >= 3){
//                       var player_1_tapped_reverse = player_1_tapped.reversed;
//                       dynamic last_entries = player_1_tapped.sublist(0, 3);
//                       last_entries.sort();
//                       last_entries = last_entries.join("");
//                       var is_playerx_win = win_game_sequence.where((element) => element == last_entries).toList();
//                       if(is_playerx_win.isNotEmpty){
//                         who_will_win = "Player X win";
//                         return;
//                       }
//                     }

//                     if(player_2_tapped.length >= 3){
//                       var player_2_tapped_reverse = player_2_tapped.reversed;
//                       dynamic last_entries = player_2_tapped.sublist(0, 3);
//                       last_entries.sort();
//                       last_entries = last_entries.join("");
//                       var is_playero_win = win_game_sequence.where((element) => element == last_entries).toList();

//                       if(is_playero_win.isNotEmpty){
//                         who_will_win = "Player O win";
//                         setState(() {
                          
//                         });
//                         return;
//                       }
//                     }
//                     area[index]["is_tapped"] = true;
//                     setState(() {});
//                   },
//                   child: Container(
//                     width: 130,
//                     height: 130,
//                     color: Colors.red,
//                     child: AnimatedOpacity(
//                       duration: Duration(milliseconds: 500),
//                       opacity: (area[index]['is_tapped'] == true ? 1 : 0),
//                       child: Icon(
//                         area[index]['icons'],
//                         size: 90,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ]);
//             }));
//   }
// }


