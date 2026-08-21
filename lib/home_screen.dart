import 'package:flutter/material.dart';
import 'player_screen.dart'; // Player ko link kiya

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Muka', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Yahan ek asli video ka ID daala hai test karne ke liye
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerScreen(videoId: 'jNQXAC9IVRw')));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  Container(
                    height: 220,
                    color: const Color(0xFF1A1A1A),
                    child: const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white54)),
                  ),
                  const ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.deepPurple),
                    title: Text('Click to Play Premium Video', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
