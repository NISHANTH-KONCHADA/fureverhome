import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfilePage extends StatefulWidget {
  // ✅ Accept current web bytes so the image doesn't reset when opening
  final Uint8List? currentWebImage;

  const MyProfilePage({super.key, this.currentWebImage});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  
  String _avatarPath = "assets/avatar.png";
  bool _isAssetAvatar = true;
  Uint8List? _webAvatarBytes;

  @override
  void initState() {
    super.initState();
    // ✅ Initialize with passed data if on web
    if (kIsWeb && widget.currentWebImage != null) {
      _webAvatarBytes = widget.currentWebImage;
      _isAssetAvatar = false;
    } else {
      _loadAvatar();
    }
  }

  Future<void> _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatarPath') ?? "assets/avatar.png";
      _isAssetAvatar = prefs.getBool('isAssetAvatar') ?? true;
      
      // Safety check for web blob URLs (which expire)
      if (kIsWeb && _avatarPath.startsWith('blob:')) {
        if (_webAvatarBytes == null) {
           _isAssetAvatar = true;
           _avatarPath = "assets/avatar.png";
        }
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _webAvatarBytes = bytes;
          _isAssetAvatar = false;
        });
        // We don't save to Prefs on web (bytes are too big). 
        // We pass it back to Home instead.
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('avatarPath', picked.path);
        await prefs.setBool('isAssetAvatar', false);
        setState(() {
          _avatarPath = picked.path;
          _isAssetAvatar = false;
        });
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF0E4839)),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF0E4839)),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getAvatarImage() {
    if (kIsWeb && _webAvatarBytes != null) return MemoryImage(_webAvatarBytes!);
    if (_isAssetAvatar) return AssetImage(_avatarPath);
    if (!kIsWeb) return FileImage(File(_avatarPath));
    return const AssetImage("assets/avatar.png");
  }

  // ✅ Helper to handle going back
  void _handleBack() {
    // Pass bytes back if web, otherwise just 'true' to signal reload
    Navigator.pop(context, kIsWeb ? _webAvatarBytes : true);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ PopScope ensures the system back button (Android) also saves data
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "My Profile",
            style: GoogleFonts.poppins(
              color: const Color(0xFF0E4839),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _handleBack, // Use our custom back handler
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0E4839), width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _getAvatarImage(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF6C00),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user?.displayName ?? "Pet Lover",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? "no-email@example.com",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              // (Your existing profile options logic remains here...)
              _buildProfileOption(icon: Icons.person_outline, title: "Edit Personal Info", onTap: (){}),
              _buildProfileOption(icon: Icons.history, title: "Adoption History", onTap: (){}),
              _buildProfileOption(icon: Icons.notifications_none, title: "Notifications", onTap: (){}),
              _buildProfileOption(icon: Icons.settings_outlined, title: "Settings", onTap: (){}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF0E4839)),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black87)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}