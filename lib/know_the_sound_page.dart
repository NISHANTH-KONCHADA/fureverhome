// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class KnowTheSoundPage extends StatefulWidget {
//   const KnowTheSoundPage({super.key});

//   @override
//   State<KnowTheSoundPage> createState() => _KnowTheSoundPageState();
// }

// class _KnowTheSoundPageState extends State<KnowTheSoundPage> {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   final List<Map<String, String>> animals = [
//     {
//       "name": "Dog",
//       "image": "assets/dog1.png",
//       "sound": "sounds/dog_bark.mp3", // TODO: Add this sound file
//     },
//     {
//       "name": "Cat",
//       "image": "assets/cat1.png",
//       "sound": "sounds/cat_meow.mp3", // TODO: Add this sound file
//     },
//     {
//       "name": "Parrot",
//       "image": "assets/parrot.png",
//       "sound": "sounds/parrot_talk.mp3", // TODO: Add this sound file
//     },
//     {
//       "name": "Rabbit",
//       "image": "assets/rabbit1.png",
//       "sound": "sounds/rabbit_squeak.mp3", // TODO: Add this sound file
//     },
//     {
//       "name": "Horse",
//       "image": "assets/horse.png", // Using a general animal image
//       "sound": "sounds/horse_neigh.mp3", // TODO: Add this sound file
//     },
//     {
//       "name": "Cow",
//       "image": "assets/cow.png", // Using a general animal image
//       "sound": "sounds/cow_moo.mp3", // TODO: Add this sound file
//     },
//   ];

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _playSound(String soundAsset) async {
//     try {
//       await _audioPlayer.play(AssetSource(soundAsset));
//     } catch (e) {
//       print("Error playing sound: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Could not play sound. Make sure the audio file is in assets/sounds/',
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Know the Sound'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//       ),
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 1200),
//           child: GridView.builder(
//             padding: const EdgeInsets.all(24),
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 250,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//               childAspectRatio: 0.8,
//             ),
//             itemCount: animals.length,
//             itemBuilder: (context, index) {
//               final animal = animals[index];
//               return GestureDetector(
//                 onTap: () => _playSound(animal['sound']!),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         child: Image.asset(
//                           animal['image']!,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Text(
//                           animal['name']!,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class KnowTheSoundPage extends StatefulWidget {
  const KnowTheSoundPage({super.key});

  @override
  State<KnowTheSoundPage> createState() => _KnowTheSoundPageState();
}

class _KnowTheSoundPageState extends State<KnowTheSoundPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> animals = [
    {
      "name": "Dog",
      "meaning": "Barking: Alerting or Greeting",
      "image": "assets/dog1.png",
      "sound": "sounds/dog_bark.mp3",
    },
    {
      "name": "Cat",
      "meaning": "Purring: Contentment & Calm",
      "image": "assets/cat1.png",
      "sound": "sounds/cat_meow.mp3",
    },
    {
      "name": "Parrot",
      "meaning": "Squawking: Seeking Attention",
      "image": "assets/parrot.png",
      "sound": "sounds/parrot_talk.mp3",
    },
    {
      "name": "Rabbit",
      "meaning": "Thumping: Feeling Threatened",
      "image": "assets/rabbit1.png",
      "sound": "sounds/rabbit_squeak.mp3",
    },
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound(String soundAsset) async {
    try {
      await _audioPlayer.play(AssetSource(soundAsset));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio file not found in assets/sounds/')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Clean White
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E4839)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sound Guide',
          style: TextStyle(
            fontFamily: "Boyers",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0E4839),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Understand your Pet",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0E4839),
                  ),
                ),
                Text(
                  "Tap an animal to hear their sound and learn what it means.",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return GestureDetector(
                  onTap: () => _playSound(animal['sound']!),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              animal['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => const Icon(Icons.pets,
                                  size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        Text(
                          animal['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0E4839),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            animal['meaning']!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}