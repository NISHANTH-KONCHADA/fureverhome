import 'package:flutter/material.dart';
import 'pet_adoption_confirmation.dart';
import 'home_page.dart';

class AdoptPetPage extends StatelessWidget {
  final Map<String, String> pet;

  const AdoptPetPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E4839),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // set your arrow color here
        ),
        title: const Text(
          "Pet Adopt",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Boyers",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                pet["image"]!,
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              pet["name"] ?? "",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Breed: ${pet["breed"] ?? ""}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Age: ${pet["age"] ?? pet["details"] ?? ""}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Weight: ${pet["weight"] ?? "25kg"}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Food: ${pet["food"] ?? "Pedigree"}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Other Info: ${pet["other"] ?? "Eats a lot of Food"}",
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E4839),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  adoptedPets.add(pet);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PetAdoptionConfirmation(pet: pet),
                    ),
                  );
                },
                child: const Text(
                  "Adopt This Pet",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Ensure google_fonts is in pubspec
// import 'pet_adoption_confirmation.dart';
// import 'home_page.dart'; // Needed for adoptedPets list

// class AdoptPetPage extends StatelessWidget {
//   final Map<String, String> pet;

//   const AdoptPetPage({super.key, required this.pet});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               // 1. Collapsing Image Header
//               SliverAppBar(
//                 expandedHeight: 400,
//                 pinned: true,
//                 backgroundColor: const Color(0xFF0E4839),
//                 elevation: 0,
//                 leading: Container(
//                   margin: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Hero(
//                     tag: pet["name"]!,
//                     child: Image.asset(
//                       pet["image"]!,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),

//               // 2. Scrollable Details
//               SliverToBoxAdapter(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//                   ),
//                   transform: Matrix4.translationValues(0, -30, 0),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 pet["name"] ?? "",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                   color: const Color(0xFF0E4839),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 pet["breed"] ?? "",
//                                 style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF6FFF8),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: const Icon(Icons.favorite_border, color: Color(0xFF0E4839)),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Stat Cards (Age, Sex, Weight)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _buildStatCard("Age", pet["age"] ?? ""),
//                           _buildStatCard("Sex", pet["gender"] ?? ""),
//                           _buildStatCard("Weight", pet["weight"] ?? ""),
//                         ],
//                       ),
//                       const SizedBox(height: 24),

//                       // Owner / Shelter Info
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade200),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: const CircleAvatar(
//                             backgroundImage: AssetImage("assets/avatar.png"),
//                             radius: 24,
//                           ),
//                           title: Text("FurEver Shelter", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
//                           subtitle: Text("Verified • 2 years active", style: GoogleFonts.poppins(fontSize: 12)),
//                           trailing: Container(
//                             decoration: BoxDecoration(color: const Color(0xFFE8F6EF), borderRadius: BorderRadius.circular(10)),
//                             child: IconButton(
//                               icon: const Icon(Icons.chat, color: Color(0xFF0E4839)),
//                               onPressed: () {}, 
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Divider(height: 40),

//                       // Description
//                       Text(
//                         "About ${pet["name"]}",
//                         style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0E4839)),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         pet["other"] ?? "No description available.",
//                         style: GoogleFonts.poppins(fontSize: 15, color: Colors.black54, height: 1.6),
//                       ),
//                       const SizedBox(height: 100), // Space for bottom button
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // 3. Floating Adopt Button
//           Positioned(
//             bottom: 24,
//             left: 24,
//             right: 24,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF0E4839),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 elevation: 10,
//                 shadowColor: const Color(0xFF0E4839).withOpacity(0.4),
//               ),
//               onPressed: () {
//                 adoptedPets.add(pet);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => PetAdoptionConfirmation(pet: pet)),
//                 );
//               },
//               child: Text(
//                 "Adopt Me Now",
//                 style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard(String label, String value) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.grey.shade100),
//         boxShadow: [
//            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             label,
//             style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: GoogleFonts.poppins(
//               color: const Color(0xFF0E4839),
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }