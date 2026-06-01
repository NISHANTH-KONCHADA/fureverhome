// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'package:firebase_auth/firebase_auth.dart'; // Import Auth

// class CommunityFeedPage extends StatefulWidget {
//   const CommunityFeedPage({super.key});

//   @override
//   State<CommunityFeedPage> createState() => _CommunityFeedPageState();
// }

// class _CommunityFeedPageState extends State<CommunityFeedPage> {
//   final TextEditingController _postController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Keep local state minimal for image selection and posting status
//   File? _selectedImage;
//   bool _isPosting = false;
//   String? _errorMsg;

//   // --- Utility for time display (no change needed) ---
//   String formatTimeAgo(DateTime dateTime) {
//     final now = DateTime.now();
//     final diff = now.difference(dateTime);
//     if (diff.inSeconds < 60) return 'just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     if (diff.inDays < 7) return '${diff.inDays}d ago';
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//   }

//   // --- 1. Image Picker (Simplified for Firebase) ---
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     // Use ImageSource.gallery for picking an image
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//     if (picked != null) {
//       setState(() => _selectedImage = File(picked.path));
//     }
//   }

//   // --- 2. SUBMIT POST (Firebase Logic) ---
//   Future<void> _submitPost() async {
//     final user = _auth.currentUser;
//     final text = _postController.text.trim();

//     if (text.isEmpty && _selectedImage == null) return;
//     if (user == null) {
//       setState(() => _errorMsg = 'You must be logged in to post.');
//       return;
//     }

//     // NOTE: Image uploading to Firebase Storage is typically required here,
//     // but for simplicity, we'll skip the actual upload and just store text and image path locally.
//     // A complete implementation needs the firebase_storage package.

//     setState(() {
//       _isPosting = true;
//       _errorMsg = null;
//     });

//     try {
//       // Data to store in Firestore
//       final Map<String, dynamic> postData = {
//         'text': text,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': user.uid,
//         'userName':
//             user.displayName ?? user.email?.split('@').first ?? 'Pet Lover',
//         'imageUrl':
//             null, // Placeholder for actual image URL from Firebase Storage
//         'likes': 0, // Initialize likes
//       };

//       // Add the post to the 'community_posts' collection
//       await _firestore.collection('community_posts').add(postData);

//       // Clear local state upon success
//       _postController.clear();
//       _selectedImage = null;
//     } on FirebaseException catch (e) {
//       setState(() => _errorMsg = 'Firebase Error: ${e.message}');
//     } catch (e) {
//       setState(() => _errorMsg = 'Failed to submit post: $e');
//     } finally {
//       setState(() => _isPosting = false);
//     }
//   }

//   // --- 3. WIDGET TO BUILD A POST (Updated to handle Firestore data) ---
//   Widget _buildPostTile({
//     required String text,
//     required String user,
//     required Timestamp timestamp,
//     required int likes,
//     String? imageUrl,
//     String? userId,
//   }) {
//     final isMe = userId == _auth.currentUser?.uid;
//     final displayTime = (timestamp.toDate());

//     return Card(
//       color: isMe
//           ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1)
//           : null,
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         formatTimeAgo(displayTime),
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Display Image if URL exists
//             if (imageUrl != null && imageUrl.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   // Note: Use Image.network for external URL from Storage
//                   // For this demo, we can't use Image.network without a real URL
//                   child: Container(
//                     height: 150,
//                     color: Colors.grey[200],
//                     child: const Center(child: Text("Image Placeholder")),
//                   ),
//                 ),
//               ),

//             // Display Post Text
//             if (text.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Text(text, style: const TextStyle(fontSize: 16)),
//               ),

//             const Divider(height: 16),

//             // Like/Interaction Row
//             Row(
//               children: [
//                 Icon(Icons.favorite, color: Colors.red, size: 20),
//                 Text(' ${likes} Likes'),
//                 // Add Reply or Share button here if desired
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- 4. WIDGET FOR MESSAGE FEED (StreamBuilder) ---
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Community Feed'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//       ),
//       body: Column(
//         children: [
//           // Post Input Area
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _postController,
//                         decoration: const InputDecoration(
//                           hintText: 'Share your pet story...',
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.image),
//                       onPressed: _pickImage,
//                     ),
//                     _isPosting
//                         ? const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             ),
//                           )
//                         : IconButton(
//                             icon: const Icon(Icons.send),
//                             onPressed: _submitPost,
//                           ),
//                   ],
//                 ),
//                 if (_selectedImage != null)
//                   Stack(
//                     alignment: Alignment.topRight,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Image.file(
//                           _selectedImage!,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.cancel, color: Colors.red),
//                         onPressed: () => setState(() => _selectedImage = null),
//                       ),
//                     ],
//                   ),
//                 if (_errorMsg != null)
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Text(
//                       _errorMsg!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           const Divider(),

//           // Real-Time Posts Display Area
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               // Listen to the 'community_posts' collection, ordered by time
//               stream: _firestore
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error loading posts: ${snapshot.error}'),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text('Be the first to share your pet story! 🐶'),
//                   );
//                 }

//                 final posts = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: posts.length,
//                   itemBuilder: (context, index) {
//                     final post = posts[index].data() as Map<String, dynamic>;

//                     // Firestore Timestamp needs conversion
//                     final Timestamp timestamp =
//                         post['timestamp'] ?? Timestamp.now();
//                     final int likes = (post['likes'] ?? 0).toInt();

//                     return _buildPostTile(
//                       text: post['text'] ?? '',
//                       user: post['userName'] ?? 'Unknown User',
//                       timestamp: timestamp,
//                       likes: likes,
//                       userId: post['userId'],
//                       imageUrl: post['imageUrl'],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }












































// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class CommunityFeedPage extends StatefulWidget {
//   const CommunityFeedPage({super.key});

//   @override
//   State<CommunityFeedPage> createState() => _CommunityFeedPageState();
// }

// class _CommunityFeedPageState extends State<CommunityFeedPage> {
//   final TextEditingController _postController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// For multiple images
//   List<XFile> _pickedImages = [];
//   List<File> _selectedImages = [];      // mobile
//   List<Uint8List> _webImages = [];      // web

//   bool _isPosting = false;
//   String? _errorMsg;

//   // ---------- Time formatting ----------
//   String formatTimeAgo(DateTime dateTime) {
//     final diff = DateTime.now().difference(dateTime);
//     if (diff.inSeconds < 60) return 'just now';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     if (diff.inDays < 7) return '${diff.inDays}d ago';
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//   }

//   // ---------- PICK MULTIPLE IMAGES ----------
//   Future<void> _pickImages() async {
//     final picker = ImagePicker();
//     final pickedList = await picker.pickMultiImage(imageQuality: 70);

//     if (pickedList.isEmpty) return;

//     _pickedImages = pickedList;

//     if (kIsWeb) {
//       final bytesList = await Future.wait(
//         pickedList.map((x) => x.readAsBytes()),
//       );
//       setState(() {
//         _webImages = bytesList;
//         _selectedImages = [];
//       });
//     } else {
//       setState(() {
//         _selectedImages = pickedList.map((x) => File(x.path)).toList();
//         _webImages = [];
//       });
//     }
//   }

//   // ---------- UPLOAD MULTIPLE IMAGES TO STORAGE ----------
//   Future<List<String>> _uploadImages(String postId) async {
//     final List<String> urls = [];

//     try {
//       for (int i = 0; i < _pickedImages.length; i++) {
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('community_posts')
//             .child('$postId-$i.jpg');

//         UploadTask uploadTask;

//         if (kIsWeb) {
//           if (_webImages.length <= i) continue;
//           uploadTask = ref.putData(_webImages[i]);
//         } else {
//           if (_selectedImages.length <= i) continue;
//           uploadTask = ref.putFile(_selectedImages[i]);
//         }

//         final snap = await uploadTask;
//         final url = await snap.ref.getDownloadURL();
//         urls.add(url);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMsg = 'Image upload failed: $e';
//       });
//     }

//     return urls;
//   }

//   // ---------- SUBMIT POST ----------
//   Future<void> _submitPost() async {
//     final user = _auth.currentUser;
//     final text = _postController.text.trim();

//     if (user == null) {
//       setState(() => _errorMsg = 'You must be logged in to post.');
//       return;
//     }

//     if (text.isEmpty && _pickedImages.isEmpty) {
//       return; // nothing to post
//     }

//     setState(() {
//       _isPosting = true;
//       _errorMsg = null;
//     });

//     try {
//       // Pre-create doc so we can use ID for storage path
//       final docRef = _firestore.collection('community_posts').doc();
//       List<String> imageUrls = [];

//       if (_pickedImages.isNotEmpty) {
//         imageUrls = await _uploadImages(docRef.id);
//       }

//       await docRef.set({
//         'text': text,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': user.uid,
//         'userName':
//             user.displayName ?? (user.email?.split('@').first ?? 'User'),
//         'imageUrls': imageUrls,
//         'likes': 0,
//       });

//       // Clear state after success
//       _postController.clear();
//       _pickedImages = [];
//       _selectedImages = [];
//       _webImages = [];
//     } on FirebaseException catch (e) {
//       setState(() => _errorMsg = 'Firebase Error: ${e.message}');
//     } catch (e) {
//       setState(() => _errorMsg = 'Failed to submit post: $e');
//     } finally {
//       setState(() => _isPosting = false);
//     }
//   }

//   // ---------- POST TILE ----------
//   Widget _buildPostTile(Map<String, dynamic> post) {
//     final Timestamp ts = (post['timestamp'] ?? Timestamp.now()) as Timestamp;
//     final DateTime time = ts.toDate();
//     final List<dynamic>? imgsDynamic = post['imageUrls'] as List<dynamic>?;
//     final List<String> imageUrls =
//         imgsDynamic != null ? imgsDynamic.map((e) => e.toString()).toList() : [];

//     final int likes = (post['likes'] ?? 0).toInt();

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header: user + time
//             Row(
//               children: [
//                 const Icon(Icons.pets, color: Colors.teal),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     post['userName'] ?? 'Pet Lover',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   formatTimeAgo(time),
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             // Images (if any)
//             if (imageUrls.isNotEmpty)
//               SizedBox(
//                 height: 180,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: imageUrls.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 8),
//                   itemBuilder: (context, index) {
//                     final url = imageUrls[index];
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                         url,
//                         height: 180,
//                         width: 220,
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   },
//                 ),
//               ),

//             if (imageUrls.isNotEmpty) const SizedBox(height: 8),

//             // Text
//             if ((post['text'] ?? '').toString().isNotEmpty)
//               Text(
//                 post['text'],
//                 style: const TextStyle(fontSize: 16),
//               ),

//             const SizedBox(height: 8),

//             // Likes row (simple display for now)
//             Row(
//               children: [
//                 const Icon(Icons.favorite, color: Colors.red, size: 18),
//                 const SizedBox(width: 4),
//                 Text('$likes Likes'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------- UI ----------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Community Feed'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Column(
//         children: [
//           // --- Create Post Area ---
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _postController,
//                         decoration: const InputDecoration(
//                           hintText: 'Share your pet story...',
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.image),
//                       onPressed: _pickImages,
//                     ),
//                     _isPosting
//                         ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : IconButton(
//                             icon: const Icon(Icons.send),
//                             onPressed: _submitPost,
//                           ),
//                   ],
//                 ),

//                 // Preview selected images
//                 if (_pickedImages.isNotEmpty)
//                   SizedBox(
//                     height: 110,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _pickedImages.length,
//                       itemBuilder: (context, index) {
//                         Widget img;
//                         if (kIsWeb && _webImages.length > index) {
//                           img = Image.memory(
//                             _webImages[index],
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           );
//                         } else if (!kIsWeb &&
//                             _selectedImages.length > index) {
//                           img = Image.file(
//                             _selectedImages[index],
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           );
//                         } else {
//                           img = Container(
//                             height: 100,
//                             width: 100,
//                             color: Colors.grey[300],
//                             child: const Icon(Icons.image),
//                           );
//                         }

//                         return Stack(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: img,
//                               ),
//                             ),
//                             Positioned(
//                               right: 0,
//                               top: 0,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _pickedImages.removeAt(index);
//                                     if (kIsWeb && _webImages.length > index) {
//                                       _webImages.removeAt(index);
//                                     } else if (!kIsWeb &&
//                                         _selectedImages.length > index) {
//                                       _selectedImages.removeAt(index);
//                                     }
//                                   });
//                                 },
//                                 child: const CircleAvatar(
//                                   radius: 10,
//                                   backgroundColor: Colors.red,
//                                   child: Icon(Icons.close,
//                                       size: 14, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),

//                 if (_errorMsg != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text(
//                       _errorMsg!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           const Divider(height: 1),

//           // --- Posts Stream ---
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('community_posts')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(
//                     child:
//                         Text('Error loading posts: ${snapshot.error.toString()}'),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text('Be the first to share your pet story! 🐶'),
//                   );
//                 }

//                 final posts = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: posts.length,
//                   itemBuilder: (context, index) {
//                     final data =
//                         posts[index].data() as Map<String, dynamic>;
//                     return _buildPostTile(data);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }































































import 'dart:convert'; // For jsonDecode
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Standard http package
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommunityFeedPage extends StatefulWidget {
  const CommunityFeedPage({super.key});

  @override
  State<CommunityFeedPage> createState() => _CommunityFeedPageState();
}

class _CommunityFeedPageState extends State<CommunityFeedPage> {
  // ----------------------------------------------------------------------
  // 🔴 TODO: REPLACE THESE WITH YOUR CLOUDINARY VALUES FROM STEP 1
  // ----------------------------------------------------------------------
  final String cloudName = "djofw1sbc"; // e.g. "dxyz123"
  final String uploadPreset = "ml_default"; // e.g. "ml_default"

  final TextEditingController _postController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<XFile> _pickedImages = [];
  List<Uint8List> _webImages = []; // Stores bytes for Web preview
  
  bool _isPosting = false;
  String? _errorMsg;

  // --- 1. PICK IMAGES ---
  Future<void> _pickImages() async {
    try {
      final picker = ImagePicker();
      final List<XFile> pickedList = await picker.pickMultiImage(imageQuality: 70);

      if (pickedList.isEmpty) return;

      if (kIsWeb) {
        // Read bytes for web preview
        final List<Uint8List> bytesList = [];
        for (var file in pickedList) {
          bytesList.add(await file.readAsBytes());
        }
        setState(() {
          _pickedImages = pickedList;
          _webImages = bytesList;
          _errorMsg = null;
        });
      } else {
        setState(() {
          _pickedImages = pickedList;
          _webImages = []; // Not needed for mobile preview (we use FileImage)
          _errorMsg = null;
        });
      }
    } catch (e) {
      setState(() => _errorMsg = 'Error picking images: $e');
    }
  }

  // --- 2. UPLOAD TO CLOUDINARY (Replaces Firebase Storage) ---
  Future<String?> _uploadSingleImageToCloudinary(XFile imageFile) async {
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        // Web: Upload from bytes
        final bytes = await imageFile.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'file', 
          bytes, 
          filename: 'upload.jpg',
        ));
      } else {
        // Mobile: Upload from path
        request.files.add(await http.MultipartFile.fromPath(
          'file', 
          imageFile.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url']; // The public URL of the image
      } else {
        print('Cloudinary Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Upload Error: $e');
      return null;
    }
  }

  Future<List<String>> _uploadAllImages() async {
    List<String> uploadedUrls = [];
    
    for (var image in _pickedImages) {
      String? url = await _uploadSingleImageToCloudinary(image);
      if (url != null) {
        uploadedUrls.add(url);
      }
    }
    return uploadedUrls;
  }

  // --- 3. SUBMIT POST ---
  Future<void> _submitPost() async {
    final user = _auth.currentUser;
    final text = _postController.text.trim();

    if (user == null) {
      setState(() => _errorMsg = 'You must be logged in to post.');
      return;
    }

    if (text.isEmpty && _pickedImages.isEmpty) {
      setState(() => _errorMsg = 'Please add text or an image.');
      return;
    }

    setState(() {
      _isPosting = true;
      _errorMsg = null;
    });

    try {
      // Upload images to Cloudinary first
      List<String> imageUrls = [];
      if (_pickedImages.isNotEmpty) {
        imageUrls = await _uploadAllImages();
      }

      // Save post data to Firestore
      await _firestore.collection('community_posts').add({
        'text': text,
        'imageUrls': imageUrls,
        'userId': user.uid,
        'userName': user.displayName ?? (user.email?.split('@')[0] ?? 'Pet Lover'),
        'timestamp': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      // Cleanup
      _postController.clear();
      setState(() {
        _pickedImages = [];
        _webImages = [];
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post shared successfully! 🐾')),
        );
      }

    } catch (e) {
      setState(() => _errorMsg = 'Failed to post: $e');
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }

  String formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return 'Just now';
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${dateTime.day}/${dateTime.month}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Feed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0E4839),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // --- CREATE POST SECTION ---
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: 'Share a pet moment...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: Color(0xFF0E4839)),
                      onPressed: _isPosting ? null : _pickImages,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E4839),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      onPressed: _isPosting ? null : _submitPost,
                      child: _isPosting 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
                // --- IMAGE PREVIEW AREA ---
                if (_pickedImages.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _pickedImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: kIsWeb
                                    ? Image.memory(_webImages[index], width: 80, height: 80, fit: BoxFit.cover)
                                    : Image.file(File(_pickedImages[index].path), width: 80, height: 80, fit: BoxFit.cover),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _pickedImages.removeAt(index);
                                      if (kIsWeb) _webImages.removeAt(index);
                                    });
                                  },
                                  child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 14, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
                if (_errorMsg != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(_errorMsg!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),

          // --- FEED LIST ---
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('community_posts').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No posts yet. Be the first! 🐶'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    final timestamp = data['timestamp'] as Timestamp?;
                    final imageUrls = List<String>.from(data['imageUrls'] ?? []);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.orange.shade100,
                                  child: Text(data['userName']?[0].toUpperCase() ?? 'U', style: const TextStyle(color: Colors.deepOrange)),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['userName'] ?? 'User', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text(formatTimeAgo(timestamp?.toDate()), style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Text
                            if (data['text'] != null && data['text'].toString().isNotEmpty)
                              Text(data['text'], style: const TextStyle(fontSize: 15)),
                            
                            // Images Grid
                            if (imageUrls.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imageUrls.length,
                                  itemBuilder: (context, imgIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          imageUrls[imgIndex],
                                          fit: BoxFit.cover,
                                          width: 200,
                                          errorBuilder: (context, error, stackTrace) => Container(width: 200, color: Colors.grey[200], child: const Icon(Icons.broken_image)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            // Actions
                            Row(
                              children: [
                                Icon(Icons.favorite_border, size: 20, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text('${data['likes'] ?? 0} Likes', style: TextStyle(color: Colors.grey[600])),
                              ],
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
    );
  }
}