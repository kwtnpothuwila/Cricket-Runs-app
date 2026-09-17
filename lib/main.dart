import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Cricket',

      // App theme
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: const CricketGameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CricketGameScreen extends StatefulWidget {
  const CricketGameScreen({super.key});

  @override
  State<CricketGameScreen> createState() => _CricketGameScreenState();
}

class _CricketGameScreenState extends State<CricketGameScreen> {
  int balls = 6;
  int totalRuns = 0;
  int? currentRun;

  // Play one ball
  void _playBall() {
    if (balls > 0) {
      setState(() {
        // Generate a random score from 0 to 6
        currentRun = Random().nextInt(7);

        // Add the score to total runs
        totalRuns += currentRun!;

        // Reduce remaining balls
        balls--;
      });
    }
  }

  // Restart the game
  void _restartGame() {
    setState(() {
      balls = 6;
      totalRuns = 0;
      currentRun = null;
    });
  }

  // Message for the current run
  String _getRunMessage() {
    if (currentRun == null) return '';

    if (currentRun == 0) {
      return 'No Runs';
    }

    if (currentRun == 1) {
      return '1 Run';
    }

    return '$currentRun Runs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // GREEN BACKGROUND
      backgroundColor: const Color(0xFF2E8B57),

      appBar: AppBar(
        title: const Text('Mini Cricket'),

        // DARK GREEN APP BAR
        backgroundColor: const Color(0xFF1B5E20),

        centerTitle: true,
        elevation: 0,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // -------------------------
            // BAT AND BALL IMAGES
            // -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageContainer('assets/bat.png'),
                _buildImageContainer('assets/ball.png'),
              ],
            ),

            const SizedBox(height: 30),

            // -------------------------
            // RUNS AND BALLS LABELS
            // -------------------------
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Runs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Balls',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // -------------------------
            // RUNS AND BALL VALUES
            // -------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$totalRuns',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '$balls',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // -------------------------
            // CURRENT RUN MESSAGE
            // -------------------------
            Text(
              _getRunMessage(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // BAT / RESTART BUTTON
            // -------------------------
            balls > 0
                ? ElevatedButton(
                    onPressed: _playBall,

                    style: ElevatedButton.styleFrom(
                      // DARK GREEN BUTTON
                      backgroundColor: const Color(0xFF176B3A),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),

                    child: const Text(
                      'Bat',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _restartGame,

                    style: ElevatedButton.styleFrom(
                      // KEEP RESTART RED
                      backgroundColor: Colors.red,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                    ),

                    child: const Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // IMAGE CONTAINER
  // -------------------------
  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 120,
      height: 120,

      // White square behind the image
      color: Colors.white,

      padding: const EdgeInsets.all(10),

      child: Image.asset(
        imagePath,

        fit: BoxFit.contain,

        // Show this icon if image cannot be loaded
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}