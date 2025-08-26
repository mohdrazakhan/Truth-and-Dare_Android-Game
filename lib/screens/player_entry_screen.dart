import 'package:flutter/material.dart';
import 'game_screen.dart';

class PlayerEntryScreen extends StatefulWidget {
  final String gameMode;
  const PlayerEntryScreen({super.key, required this.gameMode});

  @override
  State<PlayerEntryScreen> createState() => _PlayerEntryScreenState();
}

class _PlayerEntryScreenState extends State<PlayerEntryScreen> {
  final _playerController = TextEditingController();
  final List<String> _players = [];
  String _selectedMood = 'Funny';

  void _addPlayer() {
    if (_playerController.text.isNotEmpty) {
      setState(() {
        _players.add(_playerController.text);
        _playerController.clear();
      });
    }
  }

  void _startGame() {
    if (_players.length >= 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(
            gameMode: widget.gameMode,
            players: _players,
            mood: _selectedMood,
          ),
        ),
      );
    } else {
      // Show an error if not enough players
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need at least 2 players to start!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.gameMode} - Add Players'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _playerController,
              decoration: InputDecoration(
                labelText: 'Enter Player Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addPlayer,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_players[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _players.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Mood:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Funny'),
                  selected: _selectedMood == 'Funny',
                  onSelected: (selected) {
                    setState(() {
                      _selectedMood = 'Funny';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Hot'),
                  selected: _selectedMood == 'Hot',
                  onSelected: (selected) {
                    setState(() {
                      _selectedMood = 'Hot';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Extreme'),
                  selected: _selectedMood == 'Extreme',
                  onSelected: (selected) {
                    setState(() {
                      _selectedMood = 'Extreme';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
