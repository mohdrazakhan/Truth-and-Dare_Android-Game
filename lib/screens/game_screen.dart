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
  final List<String> _customTruths = [];
  final List<String> _customDares = [];
  final TextEditingController _customController = TextEditingController();
  String _customType = 'Truth';
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
    List<String> questions = List.from(
      gameData[widget.gameMode]?[type]?[widget.mood] ?? [],
    );
    if (type == 'Truth') {
      questions.addAll(_customTruths);
    } else {
      questions.addAll(_customDares);
    }
    if (questions.isEmpty)
      questions = ['No questions found for this category.'];
    final index = random.nextInt(questions.length);
    setState(() {
      _displayText = questions[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameMode),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 6,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFF8F6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Player display and spin button
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Text(
                          _isSpinning ? 'Spinning...' : 'Current Player:',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          child: Text(
                            _currentPlayer.isNotEmpty
                                ? _currentPlayer[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _currentPlayer,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _startSpin,
                          icon: const Icon(Icons.casino),
                          label: const Text('SPIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main text display
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        _displayText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),

                // Truth & Dare buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _getQuestion('Truth'),
                      icon: const Icon(Icons.question_answer),
                      label: const Text('Truth'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _getQuestion('Dare'),
                      icon: const Icon(Icons.flash_on),
                      label: const Text('Dare'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ],
                ),

                // Add custom question section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Add Custom Question',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _customController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your custom question',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _customType,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Truth',
                                  child: Text('Truth'),
                                ),
                                DropdownMenuItem(
                                  value: 'Dare',
                                  child: Text('Dare'),
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  _customType = val ?? 'Truth';
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                if (_customController.text.trim().isNotEmpty) {
                                  setState(() {
                                    if (_customType == 'Truth') {
                                      _customTruths.add(
                                        _customController.text.trim(),
                                      );
                                    } else {
                                      _customDares.add(
                                        _customController.text.trim(),
                                      );
                                    }
                                    _customController.clear();
                                  });
                                }
                              },
                              child: const Text('+ Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
