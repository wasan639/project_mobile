
import 'package:flutter/material.dart';

import 'game.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;

  @override
  void initState() {
    super.initState();
    _game = Game();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
      ),
      body: Container(
        color: Colors.yellow.shade100,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildInputPanal(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'images/number.png',
          width: 300.0,
          height: 200.0,// 160 = 1 inch
          fit: BoxFit.cover,
        ),
        Text(
          'GUESS THE NUMBER',
          style: TextStyle(fontSize: 30.0),
        ),
        Text(
          '---------',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          'IF YOU ARE REALLY GOOD!',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        Text(
          'FIND THE ANSWER',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return _guessNumber == null
        ? SizedBox.shrink()
        : Column(
      children: [
        Text(
            _guessNumber!,
            style: TextStyle(fontSize: 60.0)
        ),
        Text(
            _feedback!,
            style: TextStyle(fontSize: 40.0)
        ),
        // TextButton(
        //   onPressed: (){
        //     _game = Game();
        // },
        //     child: Text('NEW GAME'),
        // ),
      ],
    );
  }

  Widget _buildInputPanal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 10.0),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _guessNumber = _controller.text;
              int? guess = int.tryParse(_guessNumber!);
              if (guess != null) {
                var result = _game.doGuess(guess);
                if (result == 0) {
                  //ทายถูก
                  _feedback = 'CORRECT!';
                  _showMaterialDialog('$_guessNumber', '$_feedback');
                } else if (result == 1) {
                  //ทายมากไป
                  _feedback = 'TOO HIGH!';
                } else {
                  //ทายน้อยไป
                  _feedback = 'TOO LOW!';
                }
              }
            });
          },
          child: Text('GUESS'),
        ),
      ],
    );
  }
}
