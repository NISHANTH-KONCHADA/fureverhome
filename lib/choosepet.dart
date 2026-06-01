// import 'package:flutter/material.dart';
// import 'home_page.dart'; // ✅ Import HomePage
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// void main() {
//   runApp(const choose());
// }

// class choose extends StatelessWidget {
//   const choose({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF0E4839),
//         fontFamily: "Poppins",
//       ),
//       home: const CategorySelectionPage(), // ✅ first screen
//     );
//   }
// }

// class CategorySelectionPage extends StatelessWidget {
//   const CategorySelectionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent, // ✅ make Scaffold transparent
//       appBar: AppBar(
//         elevation: 6,
//         title: const Text(
//           "FurEver Home",
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
//       ),
//       body: Container(
//         // ✅ Gradient background for whole page
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFF3E0), // very light peach
//               Color(0xFFFFE0B2), // soft orange cream
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               // 🐾 Paw bones background only at the top
//               Container(
//                 height: 285, // 👈 covers from top until a bit below banner
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/paw_bone_background.png"),
//                     repeat: ImageRepeat.repeat,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               // Main content
//               Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 1000),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 8),

//                         const Text(
//                           "Find your forever friend 🐾",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black87,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // ✅ Banner (with gradient overlay)
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 12,
//                                 spreadRadius: 2,
//                                 offset: const Offset(4, 6),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Stack(
//                               children: [
//                                 Image.asset(
//                                   "assets/Banner.png",
//                                   height: 180,
//                                   width: double.infinity,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 Container(
//                                   height: 180,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.black.withOpacity(0.3),
//                                         Colors.transparent,
//                                       ],
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.topCenter,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 55),

//                         // ✅ Categories Grid
//                         Expanded(
//                           child: GridView.builder(
//                             itemCount: 4,
//                             gridDelegate:
//                                 const SliverGridDelegateWithMaxCrossAxisExtent(
//                                   maxCrossAxisExtent: 300,
//                                   mainAxisSpacing: 20,
//                                   crossAxisSpacing: 20,
//                                   childAspectRatio: 0.9,
//                                 ),
//                             itemBuilder: (context, index) {
//                               final categories = [
//                                 ["Dogs", Icons.pets, Colors.orange],
//                                 ["Cats", FontAwesomeIcons.cat, Colors.purple],
//                                 ["Birds", Icons.flutter_dash, Colors.green],
//                                 [
//                                   "Other Animals",
//                                   Icons.other_houses,
//                                   Colors.blue,
//                                 ],
//                               ];
//                               return _buildCategoryCard(
//                                 context,
//                                 categories[index][0] as String,
//                                 categories[index][1] as IconData,
//                                 categories[index][2] as Color,
//                                 index,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Category Card with Background Image
//   Widget _buildCategoryCard(
//     BuildContext context,
//     String title,
//     IconData icon,
//     Color color,
//     int categoryIndex,
//   ) {
//     // 👇 Map each category to an image
//     final images = [
//       "assets/doggo.jpg", // Dogs
//       "assets/catto.jpg", // Cats
//       "assets/birdo.jpg", // Birds
//       "assets/buno.jpg", // Other Animals
//     ];

//     return Material(
//       borderRadius: BorderRadius.circular(20),
//       elevation: 4,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => HomePage(initialIndex: categoryIndex),
//             ),
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(
//               image: AssetImage(images[categoryIndex]),
//               fit: BoxFit.cover,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.25),
//                 blurRadius: 8,
//                 offset: const Offset(3, 5),
//               ),
//             ],
//           ),
//           child: Container(
//             // 👇 dark overlay for text readability
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.black.withOpacity(0.35),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(icon, size: 40, color: Colors.white), // still shows icon
//                   const SizedBox(height: 12),
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart'; // for kIsWeb
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; 

// // Page Imports
// import 'home_page.dart';
// import 'my_profile_page.dart';
// import 'Login_Page.dart';
// import 'community_feed_page.dart';
// import 'donate_volunteer_page.dart';

// class choose extends StatelessWidget {
//   const choose({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CategorySelectionPage(),
//     );
//   }
// }

// class CategorySelectionPage extends StatefulWidget {
//   const CategorySelectionPage({super.key});

//   @override
//   State<CategorySelectionPage> createState() => _CategorySelectionPageState();
// }

// class _CategorySelectionPageState extends State<CategorySelectionPage> {
//   // Professional Theme Constants
//   final Color primaryGreen = const Color(0xFF0E4839);
//   final Color accentOrange = const Color(0xFFEF6C00);
//   final Color bgWhite = const Color(0xFFF8F9FA);

//   // Logic Variables
//   final TextEditingController _locationController = TextEditingController();
//   String _avatarPath = "assets/avatar.png";
//   bool _isAssetAvatar = true;
//   Uint8List? _webAvatarBytes;
//   bool _isDarkMode = false; 

//   @override
//   void initState() {
//     super.initState();
//     _loadAvatar();
//   }

//   // --- 1. AVATAR LOGIC ---
//   Future<void> _loadAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _avatarPath = prefs.getString('avatarPath') ?? "assets/avatar.png";
//       _isAssetAvatar = prefs.getBool('isAssetAvatar') ?? true;
//       if (kIsWeb && _avatarPath.startsWith('blob:')) {
//         _isAssetAvatar = true;
//         _avatarPath = "assets/avatar.png";
//       }
//     });
//   }

//   ImageProvider _getAvatarImage() {
//     if (kIsWeb && _webAvatarBytes != null) return MemoryImage(_webAvatarBytes!);
//     if (_isAssetAvatar) return AssetImage(_avatarPath);
//     if (!kIsWeb) return FileImage(File(_avatarPath));
//     return const AssetImage("assets/avatar.png");
//   }

//   // --- 2. SEARCH LOGIC ---
//   void _searchByLocation() {
//     final loc = _locationController.text.trim();
//     if (loc.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => HomePage(
//             initialIndex: 0,
//             locationFilter: loc,
//           ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a Pincode or City")),
//       );
//     }
//   }

//   // --- 3. HELPER DIALOGS ---
//   void _showChangePasswordDialog(BuildContext context) {
//     final TextEditingController emailController = TextEditingController();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null && user.email != null) {
//       emailController.text = user.email!;
//     }
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Reset Password'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text('Enter your email to receive a reset link:'),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white),
//               onPressed: () async {
//                 if (emailController.text.isEmpty) return;
//                 try {
//                   await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
//                   if (mounted) Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset email sent!')));
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//                 }
//               },
//               child: const Text('Send'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showOrdersOrApprovals(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("My Adopted Pets"),
//           content: SizedBox(
//             width: 300,
//             height: 300,
//             child: const Center(child: Text("No adoption history found.")), 
//           ),
//           actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
//         );
//       },
//     );
//   }

//   // --- 4. BOTTOM SHEET MENU ---
//   void _showProfileMenu() {
//     final user = FirebaseAuth.instance.currentUser;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 28,
//                       backgroundImage: _getAvatarImage(),
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           user?.displayName ?? "Pet Lover",
//                           style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: primaryGreen),
//                         ),
//                         Text(
//                           user?.email ?? "Signed in",
//                           style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 const Divider(),

//                 // Menu Items
//                 _buildMenuTile(
//                   icon: Icons.logout,
//                   title: "Logout",
//                   color: Colors.redAccent,
//                   onTap: () async {
//                     final prefs = await SharedPreferences.getInstance();
//                     await prefs.setBool('isLoggedIn', false);
//                     await FirebaseAuth.instance.signOut();
//                     if (mounted) {
//                       Navigator.pop(context);
//                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
//                     }
//                   },
//                 ),
//                 _buildMenuTile(
//                   icon: Icons.person_outline,
//                   title: "My Profile",
//                   onTap: () async {
//                     Navigator.pop(context);
//                     final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => MyProfilePage(currentWebImage: _webAvatarBytes)));
//                     if (result != null) {
//                       if (kIsWeb && result is Uint8List) {
//                         setState(() { _webAvatarBytes = result; _isAssetAvatar = false; });
//                       } else {
//                         _loadAvatar();
//                       }
//                     }
//                   },
//                 ),
//                 _buildMenuTile(
//                   icon: Icons.lock_outline,
//                   title: "Change Password",
//                   onTap: () {
//                     Navigator.pop(context);
//                     _showChangePasswordDialog(context);
//                   },
//                 ),
//                 _buildMenuTile(
//                   icon: Icons.list_alt,
//                   title: "My Orders",
//                   onTap: () {
//                     Navigator.pop(context);
//                     _showOrdersOrApprovals(context);
//                   },
//                 ),
//                 _buildMenuTile(
//                   icon: Icons.forum_outlined,
//                   title: "Community",
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityFeedPage()));
//                   },
//                 ),
//                 _buildMenuTile(
//                   icon: Icons.volunteer_activism_outlined,
//                   title: "Donate / Volunteer",
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(context, MaterialPageRoute(builder: (_) => const DonateVolunteerPage()));
//                   },
//                 ),
                
//                 const Divider(),
                
//                 // Dark Mode Switch
//                 SwitchListTile(
//                   contentPadding: EdgeInsets.zero,
//                   secondary: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
//                     child: Icon(Icons.dark_mode_outlined, color: primaryGreen),
//                   ),
//                   title: Text("Dark Mode", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
//                   value: _isDarkMode,
//                   activeColor: primaryGreen,
//                   onChanged: (val) {
//                     setState(() => _isDarkMode = val); 
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Theme preference saved!")));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMenuTile({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
//     final finalColor = color ?? primaryGreen;
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
//       leading: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(color: finalColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
//         child: Icon(icon, color: finalColor),
//       ),
//       title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black87)),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
//       onTap: onTap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgWhite,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. HEADER
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "FurEver Home",
//                         style: TextStyle(fontFamily: "Boyers", fontSize: 28, color: primaryGreen, fontWeight: FontWeight.bold, letterSpacing: 1.2),
//                       ),
//                       Text("Find your perfect companion", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
//                     ],
//                   ),
//                   // AVATAR
//                   GestureDetector(
//                     onTap: _showProfileMenu, 
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryGreen, width: 1.5)),
//                       child: CircleAvatar(radius: 22, backgroundImage: _getAvatarImage()),
//                     ),
//                   )
//                 ],
//               ),
              
//               const SizedBox(height: 24),

//               // 2. LOCATION SEARCH
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))],
//                 ),
//                 child: TextField(
//                   controller: _locationController,
//                   onSubmitted: (_) => _searchByLocation(),
//                   decoration: InputDecoration(
//                     hintText: "Enter Pincode or City...",
//                     hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 15),
//                     prefixIcon: Icon(Icons.location_on, color: accentOrange, size: 24),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                     suffixIcon: GestureDetector(
//                       onTap: _searchByLocation,
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(10)),
//                         child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // 3. HERO BANNER
//               Container(
//                 width: double.infinity,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [BoxShadow(color: accentOrange.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
//                   image: const DecorationImage(image: AssetImage("assets/fhpic.png"), fit: BoxFit.cover),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                     gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.bottomLeft, end: Alignment.topRight),
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   alignment: Alignment.bottomLeft,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Adopt, Don't Shop", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text("Give them a second chance.", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // 4. CATEGORIES
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Categories", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
//                   Text("View All", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: accentOrange)),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // 5. GRID (Fixed ChildAspectRatio to 0.8 to prevent Overflow)
//               GridView.count(
//                 crossAxisCount: 2,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 0.8, // ✅ CHANGED: 0.85 -> 0.8 (Taller cards)
//                 children: [
//                   _buildCategoryCard(context, "Dogs", "assets/doggo.jpg", 0),
//                   _buildCategoryCard(context, "Cats", "assets/catto.jpg", 1),
//                   _buildCategoryCard(context, "Birds", "assets/birdo.jpg", 2),
//                   _buildCategoryCard(context, "Other", "assets/buno.jpg", 3),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryCard(BuildContext context, String title, String imagePath, int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(initialIndex: index)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               flex: 4,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//                 child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // ✅ CHANGED: Reduced padding
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
//                 ),
//                 child: FittedBox( // ✅ CHANGED: Wrapped in FittedBox to scale down text if needed
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
//                       const SizedBox(height: 4),
//                       Text("Explore >", style: GoogleFonts.poppins(fontSize: 12, color: accentOrange, fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

// Page Imports
import 'home_page.dart';
import 'my_profile_page.dart';
import 'Login_Page.dart';
import 'community_feed_page.dart';
import 'donate_volunteer_page.dart';

class choose extends StatelessWidget {
  const choose({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategorySelectionPage(),
    );
  }
}

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> with SingleTickerProviderStateMixin {
  // Professional Theme Constants
  final Color primaryGreen = const Color(0xFF0E4839);
  final Color accentOrange = const Color(0xFFEF6C00);
  final Color bgWhite = const Color(0xFFF8F9FA);

  // Logic Variables
  final TextEditingController _locationController = TextEditingController();
  String _avatarPath = "assets/avatar.png";
  bool _isAssetAvatar = true;
  Uint8List? _webAvatarBytes;
  bool _isDarkMode = false; 
  
  // Animation Controller
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
    
    // Initialize Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- 1. AVATAR LOGIC ---
  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatarPath') ?? "assets/avatar.png";
      _isAssetAvatar = prefs.getBool('isAssetAvatar') ?? true;
      if (kIsWeb && _avatarPath.startsWith('blob:')) {
        _isAssetAvatar = true;
        _avatarPath = "assets/avatar.png";
      }
    });
  }

  ImageProvider _getAvatarImage() {
    if (kIsWeb && _webAvatarBytes != null) return MemoryImage(_webAvatarBytes!);
    if (_isAssetAvatar) return AssetImage(_avatarPath);
    if (!kIsWeb) return FileImage(File(_avatarPath));
    return const AssetImage("assets/avatar.png");
  }

  // --- 2. SEARCH LOGIC ---
  void _searchByLocation() {
    final loc = _locationController.text.trim();
    if (loc.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(
            initialIndex: 0,
            locationFilter: loc,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Pincode or City")),
      );
    }
  }

  // --- 3. HELPER DIALOGS ---
  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      emailController.text = user.email!;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email to receive a reset link:'),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white),
              onPressed: () async {
                if (emailController.text.isEmpty) return;
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
                  if (mounted) Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset email sent!')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showOrdersOrApprovals(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("My Adopted Pets"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: const Center(child: Text("No adoption history found.")), 
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
        );
      },
    );
  }

  // --- 4. BOTTOM SHEET MENU ---
  void _showProfileMenu() {
    final user = FirebaseAuth.instance.currentUser;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: _getAvatarImage(),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? "Pet Lover",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: primaryGreen),
                        ),
                        Text(
                          user?.email ?? "Signed in",
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),

                _buildMenuTile(
                  icon: Icons.logout,
                  title: "Logout",
                  color: Colors.redAccent,
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', false);
                    await FirebaseAuth.instance.signOut();
                    if (mounted) {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
                    }
                  },
                ),
                _buildMenuTile(
                  icon: Icons.person_outline,
                  title: "My Profile",
                  onTap: () async {
                    Navigator.pop(context);
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => MyProfilePage(currentWebImage: _webAvatarBytes)));
                    if (result != null) {
                      if (kIsWeb && result is Uint8List) {
                        setState(() { _webAvatarBytes = result; _isAssetAvatar = false; });
                      } else {
                        _loadAvatar();
                      }
                    }
                  },
                ),
                _buildMenuTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  onTap: () {
                    Navigator.pop(context);
                    _showChangePasswordDialog(context);
                  },
                ),
                _buildMenuTile(
                  icon: Icons.list_alt,
                  title: "My Orders",
                  onTap: () {
                    Navigator.pop(context);
                    _showOrdersOrApprovals(context);
                  },
                ),
                _buildMenuTile(
                  icon: Icons.forum_outlined,
                  title: "Community",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityFeedPage()));
                  },
                ),
                _buildMenuTile(
                  icon: Icons.volunteer_activism_outlined,
                  title: "Donate / Volunteer",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DonateVolunteerPage()));
                  },
                ),
                
                const Divider(),
                
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.dark_mode_outlined, color: primaryGreen),
                  ),
                  title: Text("Dark Mode", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  value: _isDarkMode,
                  activeColor: primaryGreen,
                  onChanged: (val) {
                    setState(() => _isDarkMode = val); 
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Theme preference saved!")));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuTile({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
    final finalColor = color ?? primaryGreen;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: finalColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: finalColor),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FurEver Home",
                          style: TextStyle(fontFamily: "Boyers", fontSize: 28, color: primaryGreen, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                        Text("Find your perfect companion", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
                      ],
                    ),
                    GestureDetector(
                      onTap: _showProfileMenu, 
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryGreen, width: 1.5)),
                        child: CircleAvatar(radius: 22, backgroundImage: _getAvatarImage()),
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 24),

                // 2. SEARCH BAR
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))],
                  ),
                  child: TextField(
                    controller: _locationController,
                    onSubmitted: (_) => _searchByLocation(),
                    decoration: InputDecoration(
                      hintText: "Enter Pincode or City...",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 15),
                      prefixIcon: Icon(Icons.location_on, color: accentOrange, size: 24),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      suffixIcon: GestureDetector(
                        onTap: _searchByLocation,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 3. HERO BANNER
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: accentOrange.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
                    image: const DecorationImage(image: AssetImage("assets/fhpic.png"), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    ),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adopt, Don't Shop", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Give them a second chance.", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 4. CATEGORIES + VIEW ALL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    
                    // ✅ FIXED: "View All" is now clickable
                    GestureDetector(
                      onTap: () {
                        // Navigate to Home Page showing all pets (index 0 usually defaults to Dogs, or we can handle "All")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(initialIndex: 0),
                          ),
                        );
                      },
                      child: Text(
                        "View All", 
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: accentOrange),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 5. GRID
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8, 
                  children: [
                    _buildCategoryCard(context, "Dogs", "assets/doggo.jpg", 0),
                    _buildCategoryCard(context, "Cats", "assets/catto.jpg", 1),
                    _buildCategoryCard(context, "Birds", "assets/birdo.jpg", 2),
                    _buildCategoryCard(context, "Other", "assets/buno.jpg", 3),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage(initialIndex: index)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), 
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                child: FittedBox( 
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text("Explore >", style: GoogleFonts.poppins(fontSize: 12, color: accentOrange, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}