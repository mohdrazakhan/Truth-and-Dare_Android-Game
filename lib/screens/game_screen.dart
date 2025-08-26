import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../data/questions.dart';

class GameScreen extends StatefulWidget {
  final String gameMode;
  final List<String> players;
  final String mood;

  const GameScreen({
    super.key,
    required this.gameMode,
    required this.players,
    required this.mood,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _currentPlayer = '';
  String _displayText = 'Spin to see who is next!';
  bool _isSpinning = false;
  Timer? _spinTimer;
  int _spinCounter = 0;

  @override
  void initState() {
    super.initState();
    widget.players.shuffle(); // Shuffle players at the start
  }

  void _startSpin() {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
      _displayText = 'Spinning...';
    });

    // Animate the player names
    _spinTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _spinCounter++;
        _currentPlayer = widget.players[_spinCounter % widget.players.length];
      });
    });

    // Stop the spin after a random duration
    final random = Random();
    final stopIn = Duration(seconds: random.nextInt(3) + 2); // 2 to 4 seconds

    Timer(stopIn, () {
      _spinTimer?.cancel();
      final winnerIndex = random.nextInt(widget.players.length);
      setState(() {
        _currentPlayer = widget.players[winnerIndex];
        _displayText = 'It\'s ${_currentPlayer}\'s turn!';
        _isSpinning = false;
      });
    });
  }

  void _getQuestion(String type) {
    if (_currentPlayer.isEmpty || _isSpinning) return;
    final random = Random();
    final questions =
        gameData[widget.gameMode]?[type]?[widget.mood] ??
        ['No questions found for this category.'];
    final index = random.nextInt(questions.length);
    setState(() {
      _displayText = questions[index];
    });
  }

  List<String> _getMoodsFor(String type) {
    return gameData[widget.gameMode]?[type]?.keys.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.gameMode), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Player display and spin button
              Column(
                children: [
                  Text(
                    _isSpinning ? 'Spinning...' : 'Current Player:',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentPlayer,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _startSpin,
                    child: const Text('SPIN'),
                  ),
                ],
              ),

              // Main text display
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    _displayText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),

              // Truth & Dare buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _getQuestion('Truth'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Truth'),
                  ),
                  ElevatedButton(
                    onPressed: () => _getQuestion('Dare'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Dare'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
