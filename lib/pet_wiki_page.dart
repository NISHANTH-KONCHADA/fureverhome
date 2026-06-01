// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PetWikiPage extends StatelessWidget {
//   const PetWikiPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           'Pet Wiki',
//           style: TextStyle(
//             fontFamily: "Boyers",
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             letterSpacing: 1.5,
//             shadows: [
//               Shadow(
//                 offset: Offset(2, 2),
//                 blurRadius: 4,
//                 color: Colors.black45,
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF0E4839),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFE8F6EF), Color(0xFFF6FFF8), Color(0xFFD6EADF)],
//           ),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
//           children: [
//             Card(
//               color: const Color(0xFFF6FFF8),
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset('assets/profile.png', height: 48),
//                         const SizedBox(width: 12),
//                         const Text(
//                           'Welcome to Pet Wiki!',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0E4839),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Find all you need to know about pets, breeds, care, and more. Explore videos, tips, and fun facts below!',
//                       style: TextStyle(fontSize: 16, color: Color(0xFF3A6351)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             _SectionTitle('Popular Pet Videos'),
//             _VideoCard(
//               title: 'Dog Breeds Explained',
//               url: 'https://youtu.be/tuRl8moQbXU?si=WQRgG_UodRE3YxdR',
//               thumbnail: 'assets/dog1.png',
//             ),
//             _VideoCard(
//               title: 'How to Care for Cats',
//               url: 'https://www.youtube.com/watch?v=uV1RMT_ld3k',
//               thumbnail: 'assets/cat1.png',
//             ),
//             _VideoCard(
//               title: 'Rabbit Care Tips',
//               url: 'https://www.youtube.com/watch?v=QvQn5fFvQ1g',
//               thumbnail: 'assets/rabbit1.png',
//             ),
//             const SizedBox(height: 24),
//             _SectionTitle('Quick Facts & Tips'),
//             _FactCard(
//               icon: Icons.pets,
//               fact:
//                   'Dogs are known for their loyalty and can learn over 100 words and gestures.',
//             ),
//             _FactCard(
//               icon: Icons.pets,
//               fact: 'Cats sleep for 12-16 hours a day and love high places.',
//             ),
//             _FactCard(
//               icon: Icons.pets,
//               fact: 'Rabbits need plenty of hay and space to hop around.',
//             ),
//             const SizedBox(height: 24),
//             _SectionTitle('Useful Resources'),
//             _ResourceCard(
//               title: 'Pet Adoption Guide',
//               url: 'https://www.petfinder.com/pet-adoption/',
//               icon: Icons.book,
//             ),
//             _ResourceCard(
//               title: 'Pet Nutrition Tips',
//               url: 'https://www.aspca.org/pet-care/cat-care/cat-nutrition-tips',
//               icon: Icons.restaurant,
//             ),
//             _ResourceCard(
//               title: 'Find a Vet Near You',
//               url: 'https://www.google.com/maps/search/vet+near+me/',
//               icon: Icons.local_hospital,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   const _SectionTitle(this.title);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF0E4839),
//         ),
//       ),
//     );
//   }
// }

// class _VideoCard extends StatelessWidget {
//   final String title;
//   final String url;
//   final String thumbnail;
//   const _VideoCard({
//     required this.title,
//     required this.url,
//     required this.thumbnail,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(14),
//         onTap: () async {
//           if (await canLaunchUrl(Uri.parse(url))) {
//             launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//           }
//         },
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Image.asset(
//                 thumbnail,
//                 height: 60,
//                 width: 60,
//                 fit: BoxFit.contain, // Ensures the image fills the space
//               ),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const Icon(
//               Icons.play_circle_fill,
//               color: Color(0xFF0E4839),
//               size: 32,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _FactCard extends StatelessWidget {
//   final IconData icon;
//   final String fact;
//   const _FactCard({required this.icon, required this.fact});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xFFE8F6EF),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, color: Color(0xFF0E4839), size: 28),
//         title: Text(fact, style: const TextStyle(fontSize: 15)),
//       ),
//     );
//   }
// }

// class _ResourceCard extends StatelessWidget {
//   final String title;
//   final String url;
//   final IconData icon;
//   const _ResourceCard({
//     required this.title,
//     required this.url,
//     required this.icon,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xFFF6FFF8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, color: Color(0xFF0E4839), size: 28),
//         title: Text(
//           title,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         trailing: const Icon(Icons.open_in_new, color: Color(0xFF0E4839)),
//         onTap: () async {
//           if (await canLaunchUrl(Uri.parse(url))) {
//             launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//           }
//         },
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class PetWikiPage extends StatelessWidget {
  const PetWikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Professional Off-White
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E4839)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pet Wiki',
          style: TextStyle( // Keeping Boyers for Brand Consistency
            fontFamily: "Boyers",
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0E4839),
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          // 1. Header Section
          Text(
            "Pet Knowledge\nHub & Tips",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0E4839),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Explore videos, fun facts, and guides.",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // 2. Welcome Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0E4839).withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F6EF),
                    shape: BoxShape.circle,
                  ),
                  // Using an icon if asset is missing, or your asset
                  child: Image.asset('assets/profile.png', height: 40, errorBuilder: (c,e,s) => const Icon(Icons.menu_book, color: Color(0xFF0E4839), size: 30)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Pet Wiki!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0E4839),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find everything you need to know about breeds and care.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // 3. Popular Videos
          _SectionTitle('Popular Pet Videos'),
          const SizedBox(height: 16),
          _VideoCard(
            title: 'Dog Breeds Explained',
            url: 'https://youtu.be/tuRl8moQbXU?si=WQRgG_UodRE3YxdR',
            thumbnail: 'assets/dog1.png',
            duration: "10 min",
          ),
          _VideoCard(
            title: 'How to Care for Cats',
            url: 'https://www.youtube.com/watch?v=uV1RMT_ld3k',
            thumbnail: 'assets/cat1.png',
            duration: "8 min",
          ),
          _VideoCard(
            title: 'Rabbit Care Tips',
            url: 'https://www.youtube.com/watch?v=QvQn5fFvQ1g',
            thumbnail: 'assets/rabbit1.png',
            duration: "12 min",
          ),

          const SizedBox(height: 32),

          // 4. Fun Facts
          _SectionTitle('Quick Facts'),
          const SizedBox(height: 16),
          _FactCard(
            icon: Icons.lightbulb_outline,
            title: "Did you know?",
            fact: 'Dogs are known for their loyalty and can learn over 100 words and gestures.',
            color: Colors.orange.shade50,
            iconColor: Colors.orange,
          ),
          _FactCard(
            icon: Icons.nights_stay_outlined,
            title: "Sleepy Heads",
            fact: 'Cats sleep for 12-16 hours a day and love high places.',
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
          ),
          _FactCard(
            icon: Icons.grass_outlined,
            title: "Hoppy Pets",
            fact: 'Rabbits need plenty of hay and space to hop around.',
            color: Colors.green.shade50,
            iconColor: Colors.green,
          ),

          const SizedBox(height: 32),

          // 5. Resources
          _SectionTitle('Useful Resources'),
          const SizedBox(height: 16),
          _ResourceCard(
            title: 'Pet Adoption Guide',
            url: 'https://www.petfinder.com/pet-adoption/',
            icon: Icons.volunteer_activism,
          ),
          _ResourceCard(
            title: 'Pet Nutrition Tips',
            url: 'https://www.aspca.org/pet-care/cat-care/cat-nutrition-tips',
            icon: Icons.restaurant_menu,
          ),
          _ResourceCard(
            title: 'Find a Vet Near You',
            url: 'https://www.google.com/maps/search/vet+near+me/',
            icon: Icons.local_hospital,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// --- WIDGETS ---

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0E4839),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String title;
  final String url;
  final String thumbnail;
  final String duration;

  const _VideoCard({
    required this.title,
    required this.url,
    required this.thumbnail,
    this.duration = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(url))) {
              launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        thumbnail,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (c,e,s) => Container(height: 70, width: 70, color: Colors.grey.shade200, child: const Icon(Icons.image)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      if (duration.isNotEmpty)
                        Text(
                          duration,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String fact;
  final Color color;
  final Color iconColor;

  const _FactCard({
    required this.icon,
    required this.title,
    required this.fact,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            fact,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final String title;
  final String url;
  final IconData icon;

  const _ResourceCard({
    required this.title,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          }
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF0E4839)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
      ),
    );
  }
}