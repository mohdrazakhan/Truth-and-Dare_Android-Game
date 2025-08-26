import 'package:flutter/material.dart';
import 'player_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToPlayerEntry(BuildContext context, String gameMode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerEntryScreen(gameMode: gameMode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Truth & Dare'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Truth & Dare!',
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Pick a mode and gather your friends or family! Each turn, a player will be chosen at random to answer a Truth or complete a Dare. Have fun and be creative!',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.family_restroom, size: 28),
                label: const Text('Family', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: Color(0xFF8E24AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () => _navigateToPlayerEntry(context, 'Family'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.celebration, size: 28),
                label: const Text('Friends', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: Color(0xFFFFC107),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () => _navigateToPlayerEntry(context, 'Friends'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.favorite,
                  size: 28,
                  color: Colors.redAccent,
                ),
                label: const Text('Couples', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: Color(0xFFE57373),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () => _navigateToPlayerEntry(context, 'Couples'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
