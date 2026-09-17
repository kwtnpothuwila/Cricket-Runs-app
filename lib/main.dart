import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CricketApp());
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cricket App',

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: const CricketHomePage(),
    );
  }
}

class CricketHomePage extends StatefulWidget {
  const CricketHomePage({super.key});

  @override
  State<CricketHomePage> createState() => _CricketHomePageState();
}

class _CricketHomePageState extends State<CricketHomePage> {
  final Random random = Random();

  final List<int?> balls = List.filled(6, null);

  int currentBall = 0;
  int totalRuns = 0;
  
  // Changed to start at 0 so the initial screen shows 0 instead of null
  int currentRun = 0;

  void playBall() {
    if (currentBall >= 6) return;

    // Changed to random.nextInt(7) to allow 0 to 6 runs just like your previous version
    final int runs = random.nextInt(7);

    setState(() {
      balls[currentBall] = runs;
      totalRuns += runs;
      currentRun = runs;
      currentBall++;
    });
  }

  void restartGame() {
    setState(() {
      for (int i = 0; i < balls.length; i++) {
        balls[i] = null;
      }

      currentBall = 0;
      totalRuns = 0;
      currentRun = 0;
    });
  }

  // Now returns the running total instead of the single run message
  String getTotalMessage() {
    if (currentBall == 0 && totalRuns == 0) {
      return ''; // Keep empty before first click
    }
    return 'Total: $totalRuns Runs';
  }

  @override
  Widget build(BuildContext context) {
    final bool gameFinished = currentBall == 6;

    return Scaffold(
      // GREEN BACKGROUND
      backgroundColor: const Color(0xFF2E8B57),

      // -------------------------
      // APP BAR
      // -------------------------
      appBar: AppBar(
        title: const Text('Cricket App'),
        centerTitle: true,

        backgroundColor: const Color(0xFF1B5E20),

        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageContainer('assets/bat.png'),
                _buildImageContainer('assets/ball.png'),
              ],
            ),

            const SizedBox(height: 25),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Runs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Balls',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // CHANGED: Now displays the current random run for the specific ball
                Text(
                  '$currentRun',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${6 - currentBall}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // CHANGED: Now shows the Total Runs message
            Text(
              gameFinished ? 'Game Over! Total: $totalRuns Runs' : getTotalMessage(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            gameFinished
                ? ElevatedButton(
                    onPressed: restartGame,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),

                    child: const Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: playBall,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF176B3A),
                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 12,
                      ),
                    ),

                    child: const Text(
                      'Bat',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 120,
      height: 120,

      color: Colors.white,

      padding: const EdgeInsets.all(10),

      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,

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