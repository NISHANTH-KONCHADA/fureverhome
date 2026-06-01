import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'adopt_pet_page.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pet_wiki_page.dart';
import 'services_page.dart';
import 'gemini_chat_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'know_the_sound_page.dart';
import 'dart:io';
import 'community_feed_page.dart';
import 'choose_pet.dart';
import 'donate_volunteer_page.dart';
import 'my_profile_page.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cloud_firestore/cloud_firestore.dart';

// Global list to store adopted pets locally (in memory)
List<Map<String, String>> adoptedPets = [];

typedef ThemeChangedCallback = void Function(bool isDark);

class HomePage extends StatefulWidget {
  final int initialIndex;
  final ThemeChangedCallback? onThemeChanged;
  final bool? isDark;
  final String userRole;
  final String? locationFilter;

  const HomePage({
    super.key,
    this.initialIndex = 0,
    this.onThemeChanged,
    this.isDark,
    this.userRole = 'normal',
    this.locationFilter,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  late int selectedIndex;

  String _avatarPath = "assets/avatar.png";
  bool _isAssetAvatar = true;
  Uint8List? _webAvatarBytes;

  // Voice Search State Variables
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  List<Map<String, String>> _filteredPets = [];
  bool _isSearchingByVoice = false;

  final List<String> categories = ["Dogs", "Cats", "Birds", "Other"];

  final Map<String, List<Map<String, String>>> petsByCategory = {
    "Cats": [
      {
        "name": "Mono LaMi",
        "breed": "British Shorthair",
        "age": "1 year",
        "gender": "Female",
        "weight": "4.5kg",
        "location": "New York, 10001",
        "food": "Royal Canin, Whiskas",
        "other": "Calm, affectionate. Vaccinated.",
        "image": "assets/cat1.png",
      },
      {
        "name": "Simba",
        "breed": "Maine Coon",
        "age": "3 years",
        "gender": "Male",
        "weight": "7.2kg",
        "location": "California, 90210",
        "food": "Royal Canin, Chicken",
        "other": "Large, gentle, loves water.",
        "image": "assets/cat3.png",
      },
    ],
    "Dogs": [
      {
        "name": "Rocky",
        "breed": "Golden Retriever",
        "age": "3 years",
        "gender": "Male",
        "weight": "32kg",
        "location": "Texas, 75001",
        "food": "Pedigree, Chicken",
        "other": "Friendly, loves fetch.",
        "image": "assets/dog1.png",
      },
      {
        "name": "Bella",
        "breed": "German Shepherd",
        "age": "2 years",
        "gender": "Female",
        "weight": "28kg",
        "location": "New York, 10001",
        "food": "Pedigree, Beef",
        "other": "Loyal, intelligent guard dog.",
        "image": "assets/dog2.png",
      },
      {
        "name": "Max",
        "breed": "Labrador",
        "age": "4 years",
        "gender": "Male",
        "weight": "30kg",
        "food": "Pedigree, Chicken, Fish",
        "other": "Energetic, loves walks, gentle with kids. Needs daily exercise.",
        "image": "assets/dog3.png",
      },
      {
        "name": "Daisy",
        "breed": "Beagle",
        "age": "1 year",
        "gender": "Female",
        "weight": "10kg",
        "food": "Pedigree, Turkey, Carrots",
        "other": "Curious, loves sniffing, playful. Good for active owners.",
        "image": "assets/dog4.png",
      },
      {
        "name": "Charlie",
        "breed": "Pug",
        "age": "2 years",
        "gender": "Male",
        "weight": "8kg",
        "food": "Pedigree, Chicken, Rice",
        "other": "Comical, affectionate, loves cuddles. Indoor dog, healthy.",
        "image": "assets/dog5.png",
      },
      {
        "name": "Lucy",
        "breed": "Shih Tzu",
        "age": "3 years",
        "gender": "Female",
        "weight": "6kg",
        "food": "Pedigree, Lamb, Carrots",
        "other": "Small, sweet, loves laps. Needs regular grooming, vaccinated.",
        "image": "assets/doggo.jpg",
      },
      {
        "name": "Cooper",
        "breed": "Boxer",
        "age": "5 years",
        "gender": "Male",
        "weight": "27kg",
        "food": "Pedigree, Beef, Chicken",
        "other": "Athletic, playful, good with older kids. Neutered, microchipped.",
        "image": "assets/dog1.png",
      },
    ],
    "Birds": [
      {
        "name": "Kiwi",
        "breed": "Parrot",
        "age": "1 year",
        "gender": "Female",
        "weight": "0.9kg",
        "food": "Fruits, Seeds, Nuts",
        "other": "Talks, loves fruit, enjoys shoulder rides. Cage included.",
        "image": "assets/parrot.png",
      },
      {
        "name": "Coco",
        "breed": "Cockatiel",
        "age": "2 years",
        "gender": "Male",
        "weight": "0.1kg",
        "food": "Seeds, Millet, Apple",
        "other": "Whistles tunes, friendly, hand-tamed. Needs daily interaction.",
        "image": "assets/cock.png",
      },
      {
        "name": "Sunny",
        "breed": "Budgerigar",
        "age": "1 year",
        "gender": "Male",
        "weight": "0.04kg",
        "food": "Seeds, Greens, Carrot",
        "other": "Colorful, active, loves mirrors. Easy to care for.",
        "image": "assets/bird3.png",
      },
      {
        "name": "Sky",
        "breed": "Lovebird",
        "age": "2 years",
        "gender": "Female",
        "weight": "0.05kg",
        "food": "Seeds, Fruits, Spinach",
        "other": "Social, loves company, beautiful feathers. Cage trained.",
        "image": "assets/bird4.png",
      },
      {
        "name": "Peach",
        "breed": "Finch",
        "age": "3 years",
        "gender": "Female",
        "weight": "0.02kg",
        "food": "Seeds, Eggfood, Greens",
        "other": "Small, sings, easy to keep. Good for beginners.",
        "image": "assets/birdo.jpg",
      },
      {
        "name": "Blue",
        "breed": "Macaw",
        "age": "4 years",
        "gender": "Male",
        "weight": "1.2kg",
        "food": "Fruits, Seeds, Pellets",
        "other": "Large, intelligent, needs space. Trained, healthy.",
        "image": "assets/bird1.png",
      },
      {
        "name": "Mango",
        "breed": "Canary",
        "age": "2 years",
        "gender": "Male",
        "weight": "0.03kg",
        "food": "Seeds, Greens, Apple",
        "other": "Sings beautifully, bright yellow, easy care.",
        "image": "assets/bird2.png",
      },
    ],
    "Other": [
      {
        "name": "Bunny",
        "breed": "Rabbit",
        "age": "6 months",
        "gender": "Female",
        "weight": "1.5kg",
        "food": "Carrots, Hay, Pellets",
        "other": "Soft, gentle, loves carrots. Litter trained, cage included.",
        "image": "assets/rabbit1.png",
      },
      {
        "name": "Hammy",
        "breed": "Hamster",
        "age": "1 year",
        "gender": "Male",
        "weight": "0.08kg",
        "food": "Seeds, Nuts, Apple",
        "other": "Active at night, loves tunnels. Easy to care for, comes with wheel.",
        "image": "assets/hamster.png",
      },
      {
        "name": "Turtle",
        "breed": "Tortoise",
        "age": "5 years",
        "gender": "Female",
        "weight": "2.2kg",
        "food": "Leafy greens, Fruits, Pellets",
        "other": "Slow, peaceful, enjoys basking. Needs aquarium, healthy.",
        "image": "assets/turtle.png",
      },
      {
        "name": "Guinea",
        "breed": "Guinea Pig",
        "age": "2 years",
        "gender": "Male",
        "weight": "1.0kg",
        "food": "Veggies, Hay, Pellets",
        "other": "Social, squeaks, loves veggies. Good for kids, cage included.",
        "image": "assets/pg.png",
      },
      {
        "name": "Ferret",
        "breed": "Ferret",
        "age": "3 years",
        "gender": "Female",
        "weight": "1.2kg",
        "food": "Chicken, Turkey, Pellets",
        "other": "Playful, curious, loves tunnels. Needs time outside cage.",
        "image": "assets/ferret.png",
      },
      {
        "name": "Chinchilla",
        "breed": "Chinchilla",
        "age": "4 years",
        "gender": "Male",
        "weight": "0.6kg",
        "food": "Hay, Pellets, Raisins",
        "other": "Soft fur, jumps high, dust baths. Needs large cage.",
        "image": "assets/chin.png",
      },
      {
        "name": "Ratty",
        "breed": "Rat",
        "age": "2 years",
        "gender": "Female",
        "weight": "0.3kg",
        "food": "Seeds, Fruits, Pellets",
        "other": "Smart, friendly, enjoys mazes. Good for gentle owners.",
        "image": "assets/rabbit1.png",
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    _loadAvatar();
    _saveLoginStatus();
    _initSpeech();

    if (widget.locationFilter != null && widget.locationFilter!.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        _applyVoiceFilter(widget.locationFilter!);
      });
    }
  }

  // ─── VOICE SEARCH LOGIC ───────────────────────────────────────────────────

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onError: (errorDetails) => debugPrint('STT Error: ${errorDetails.errorMsg}'),
      onStatus: (status) => debugPrint('STT Status: $status'),
    );
    if (mounted) setState(() {});
  }

  void _applyVoiceFilter(String voiceCommand) {
    final command = voiceCommand.toLowerCase();

    String category = categories[selectedIndex];
    if (command.contains('dog')) category = 'Dogs';
    else if (command.contains('cat')) category = 'Cats';
    else if (command.contains('bird')) category = 'Birds';

    List<Map<String, String>> allPets = [];
    if (widget.locationFilter != null) {
      for (final list in petsByCategory.values) {
        allPets.addAll(list);
      }
    } else {
      allPets = petsByCategory[categories[selectedIndex]] ?? [];
    }

    final results = allPets.where((pet) {
      final petInfo = (pet['other'] ?? '').toLowerCase();
      final petName = (pet['name'] ?? '').toLowerCase();
      final petLoc = (pet['location'] ?? '').toLowerCase();
      return petName.contains(command) || petInfo.contains(command) || petLoc.contains(command);
    }).toList();

    setState(() {
      _lastWords = voiceCommand;
      _filteredPets = results;
      _isSearchingByVoice = true;
      if (category != categories[selectedIndex]) {
        selectedIndex = categories.indexOf(category);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Search: "$voiceCommand" — ${_filteredPets.length} pets found.')),
    );
  }

  void _startListening() async {
    if (!_speechEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available.')),
      );
      return;
    }
    setState(() => _lastWords = 'Listening...');
    await _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          _applyVoiceFilter(result.recognizedWords);
          _speechToText.stop();
        } else {
          setState(() => _lastWords = result.recognizedWords);
        }
      },
      listenFor: const Duration(seconds: 5),
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _clearFilter() {
    setState(() {
      _isSearchingByVoice = false;
      _filteredPets = [];
      _lastWords = '';
    });
  }

  // ─── GEMINI CHAT ──────────────────────────────────────────────────────────

  Widget _buildGeminiChatButton() {
    return FloatingActionButton(
      heroTag: "geminiChat",
      backgroundColor: const Color(0xFFEF6C00),
      child: const Icon(Icons.chat, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => const GeminiChatSheet(),
        );
      },
    );
  }

  // ─── SINGLE PET RESULT MODULE ─────────────────────────────────────────────

  Widget _buildSinglePetModule(Map<String, String> pet) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: _clearFilter,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Full List'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Best Match for: "$_lastWords"',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0E4839),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdoptPetPage(pet: pet)),
                );
              },
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                margin: const EdgeInsets.only(bottom: 22),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            pet["image"]!,
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet["name"] ?? "Pet Name",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0E4839),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text("Breed: ${pet["breed"] ?? ""}", style: const TextStyle(fontSize: 16)),
                            Text("Age: ${pet["age"] ?? ""}", style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 10),
                            Text(
                              "Info: ${pet["other"] ?? ""}",
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
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

  // ─── UTILITY METHODS ──────────────────────────────────────────────────────

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

  Future<void> _changeAvatar(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Avatar'),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatarOption(context, Icons.photo_library, 'Pick from Gallery', ImageSource.gallery),
              const SizedBox(height: 18),
              _buildAvatarOption(context, Icons.camera_alt, 'Capture with Camera', ImageSource.camera),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ],
      ),
    );
  }

  Widget _buildAvatarOption(BuildContext context, IconData icon, String label, ImageSource source) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0E4839),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: source, imageQuality: 80);
        if (picked != null) {
          if (kIsWeb) {
            final bytes = await picked.readAsBytes();
            setState(() {
              _webAvatarBytes = bytes;
              _isAssetAvatar = false;
            });
          } else {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('avatarPath', picked.path);
            await prefs.setBool('isAssetAvatar', false);
            setState(() {
              _avatarPath = picked.path;
              _isAssetAvatar = false;
            });
          }
          if (context.mounted) Navigator.pop(context);
        }
      },
    );
  }

  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) emailController.text = user!.email!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email to receive a password reset link:'),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email.')));
                  return;
                }
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  await FirebaseAuth.instance.signOut();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent!')),
                  );
                } on FirebaseAuthException catch (e) {
                  final msg = e.code == 'user-not-found' ? 'No user found for that email.' : 'Failed to send reset email.';
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
    final isVolunteer = widget.userRole == 'volunteer';
    final String title = isVolunteer ? 'Pending Approvals' : 'My Adopted Pets';

    showDialog(
      context: context,
      builder: (context) {
        if (isVolunteer) {
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: 300,
              height: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('adoption_requests')
                    .where('status', isEqualTo: 'Pending')
                    .orderBy('request_date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No pending requests! 🎉'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        leading: const Icon(Icons.pending, color: Colors.orange),
                        title: Text('${data['pet_name']}'),
                        subtitle: Text('User: ${data['contact_details']['name']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check_circle, color: Colors.green),
                              onPressed: () => doc.reference.update({
                                'status': 'Approved',
                                'approved_by': FirebaseAuth.instance.currentUser?.email ?? 'Volunteer',
                                'approved_date': FieldValue.serverTimestamp(),
                              }),
                            ),
                            IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () => doc.reference.update({'status': 'Rejected'}),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: adoptedPets.isEmpty
                ? const Text('No pets adopted yet.')
                : SizedBox(
                    width: 300,
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: adoptedPets.length,
                      itemBuilder: (context, index) {
                        final pet = adoptedPets[index];
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: AssetImage(pet['image'] ?? '')),
                          title: Text(pet['name'] ?? ''),
                          subtitle: const Text('Status: Pending Volunteer Review'),
                        );
                      },
                    ),
                  ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
          );
        }
      },
    );
  }

  ImageProvider _getAvatarImage() {
    if (kIsWeb && _webAvatarBytes != null) return MemoryImage(_webAvatarBytes!);
    if (_isAssetAvatar) return AssetImage(_avatarPath);
    if (!kIsWeb) return FileImage(File(_avatarPath));
    return const AssetImage("assets/avatar.png");
  }

  // ─── BUILD ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String selectedCategory = categories[selectedIndex];
    List<Map<String, String>> displayPets;

    final bool showSingleModule = _isSearchingByVoice && _filteredPets.length == 1;

    if (showSingleModule) {
      displayPets = [_filteredPets.first];
    } else if (_isSearchingByVoice) {
      displayPets = _filteredPets;
    } else {
      displayPets = petsByCategory[selectedCategory] ?? [];
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_isSearchingByVoice) {
          _clearFilter();
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const choose()),
            (route) => false,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF8F9FA), Color(0xFFF8F9FA), Color(0xFFF8F9FA)],
                ),
          image: isDark
              ? null
              : const DecorationImage(
                  image: AssetImage('assets/paw_bone_background.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Color(0x14FFFFFF), BlendMode.dstATop),
                ),
        ),
        child: Scaffold(
          backgroundColor: isDark ? Theme.of(context).colorScheme.surface : Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const choose()),
                  (route) => false,
                );
              },
            ),
            title: const Text(
              "FurEver Home",
              style: TextStyle(
                fontFamily: "Boyers",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF0E4839),
            elevation: 4,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.logout, color: Color(0xFF0E4839)),
                                title: const Text('Logout'),
                                onTap: () async {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool('isLoggedIn', false);
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginPage()),
                                    (route) => false,
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.person, color: Color(0xFF0E4839)),
                                title: const Text('My Profile'),
                                onTap: () async {
                                  Navigator.pop(context);
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MyProfilePage(currentWebImage: _webAvatarBytes),
                                    ),
                                  );
                                  if (result != null) {
                                    if (kIsWeb && result is Uint8List) {
                                      setState(() {
                                        _webAvatarBytes = result;
                                        _isAssetAvatar = false;
                                      });
                                    } else {
                                      _loadAvatar();
                                    }
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.lock, color: Color(0xFF0E4839)),
                                title: const Text('Change Password'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _showChangePasswordDialog(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  widget.userRole == 'volunteer' ? Icons.check_circle_outline : Icons.list_alt,
                                  color: const Color(0xFF0E4839),
                                ),
                                title: Text(widget.userRole == 'volunteer' ? 'Approval Queue' : 'My Orders'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _showOrdersOrApprovals(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.forum, color: Color(0xFF0E4839)),
                                title: const Text('Community'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityFeedPage()));
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.volunteer_activism, color: Color(0xFF0E4839)),
                                title: const Text('Donate / Volunteer'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DonateVolunteerPage()));
                                },
                              ),
                              const Divider(),
                              SwitchListTile(
                                secondary: const Icon(Icons.dark_mode, color: Color(0xFF0E4839)),
                                title: const Text('Dark Mode'),
                                value: widget.isDark ?? isDark,
                                onChanged: (val) {
                                  if (widget.onThemeChanged != null) widget.onThemeChanged!(val);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: _getAvatarImage(),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adopt your pet's here!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0E4839),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '"Until one has loved an animal, a part of one\'s soul remains unawakened."',
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: isDark ? Theme.of(context).colorScheme.secondary : Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Voice filter status bar or category tabs
                  if (_isSearchingByVoice && !showSingleModule)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Voice Filter: "$_lastWords" (${_filteredPets.length} results)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.clear, size: 20), onPressed: _clearFilter),
                        ],
                      ),
                    )
                  else if (_isSearchingByVoice && showSingleModule)
                    const SizedBox.shrink()
                  else
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final isSelected = index == selectedIndex;
                          const icons = [Icons.pets, Icons.pets, Icons.bug_report, Icons.emoji_nature];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                _clearFilter();
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF0E4839) : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: isSelected
                                    ? [BoxShadow(color: isDark ? Colors.black26 : Colors.orange.shade100, blurRadius: 6)]
                                    : [],
                              ),
                              child: Row(
                                children: [
                                  Icon(icons[index], color: isSelected ? Colors.white : const Color(0xFF0E4839), size: 22),
                                  const SizedBox(width: 8),
                                  Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : const Color(0xFF0E4839),
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 18),

                  // Pet list area
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (showSingleModule) {
                          return _buildSinglePetModule(displayPets.first);
                        } else if (_isSearchingByVoice && _filteredPets.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.pets_sharp, size: 60, color: Colors.redAccent),
                                const SizedBox(height: 16),
                                Text(
                                  'No pets found matching your search.',
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
                                ),
                                TextButton.icon(
                                  onPressed: _clearFilter,
                                  icon: const Icon(Icons.list),
                                  label: const Text('Show All Pets'),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: displayPets.length,
                          itemBuilder: (context, index) {
                            final pet = displayPets[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AdoptPetPage(pet: pet)),
                                );
                              },
                              child: Card(
                                color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
                                elevation: 7,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                margin: const EdgeInsets.only(bottom: 22),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                      ),
                                      child: Image.asset(pet["image"]!, width: 140, height: 130, fit: BoxFit.contain),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(18),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pet["name"] ?? "",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF0E4839),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text("Breed: ${pet["breed"] ?? ""}", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                                            Text("Age: ${pet["age"] ?? ""} | Gender: ${pet["gender"] ?? ""}", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                                            Text("Weight: ${pet["weight"] ?? ""}", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
                                            const SizedBox(height: 4),
                                            Text(
                                              pet["other"] ?? "",
                                              style: TextStyle(fontSize: 14, color: isDark ? Theme.of(context).colorScheme.secondary : Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: const Color(0xFF0E4839),
              unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              currentIndex: _bottomNavIndex,
              onTap: _onBottomNavTap,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Choose Pet'),
                BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services), label: 'Services'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Pet Wiki'),
                BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Know Sound'),
              ],
            ),
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Positioned(
                bottom: 16,
                right: 16,
                child: _buildGeminiChatButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onBottomNavTap(int index) async {
    if (index == 0) {
      _clearFilter();
      selectedIndex = 0;
    }
    setState(() => _bottomNavIndex = index);
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ServicesPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PetWikiPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const KnowTheSoundPage()));
        break;
    }
  }
}