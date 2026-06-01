// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'reservation_confirm_dialog.dart';

// List<Map<String, String>> reservedServices = [];

// class ServicesPage extends StatefulWidget {
//   const ServicesPage({super.key});

//   @override
//   State<ServicesPage> createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   void _showReservedServices() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('My Reserved Services'),
//           content: reservedServices.isEmpty
//               ? const Text('No reservations yet.')
//               : SizedBox(
//                   width: 300,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: reservedServices.length,
//                     itemBuilder: (context, index) {
//                       final res = reservedServices[index];
//                       final isVet = res['service'] == 'Veterinary Care';
//                       return ListTile(
//                         leading: const Icon(
//                           Icons.bookmark,
//                           color: Colors.green,
//                         ),
//                         title: Text(res['service'] ?? ''),
//                         subtitle: Text(
//                           'Time: ${res['time'] ?? ''}\nContact: ${res['contact'] ?? ''}',
//                         ),
//                         trailing: isVet
//                             ? IconButton(
//                                 icon: const Icon(
//                                   Icons.location_on,
//                                   color: Color(0xFF0E4839),
//                                 ),
//                                 tooltip: 'Find Vets Near Me',
//                                 onPressed: () async {
//                                   final url = Uri.parse(
//                                     'https://maps.app.goo.gl/AJSrNCb4iGc1jmgG9',
//                                   );
//                                   if (await canLaunchUrl(url)) {
//                                     await launchUrl(
//                                       url,
//                                       mode: LaunchMode.externalApplication,
//                                     );
//                                   }
//                                 },
//                               )
//                             : null,
//                       );
//                     },
//                   ),
//                 ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFFE8F6EF), // soft mint
//             Color(0xFFF6FFF8), // light cream
//             Color(0xFFD6EADF), // pale green
//           ],
//         ),
//         image: DecorationImage(
//           image: AssetImage('assets/paw_bone_background.png'),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(Color(0x14FFFFFF), BlendMode.dstATop),
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: const Text(
//             'Pet Services',
//             style: TextStyle(
//               fontFamily: "Boyers",
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               letterSpacing: 1.5,
//               shadows: [
//                 Shadow(
//                   offset: Offset(2, 2),
//                   blurRadius: 4,
//                   color: Colors.black45,
//                 ),
//               ],
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: const Color(0xFF0E4839),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.bookmark),
//               tooltip: 'My Reserved Services',
//               onPressed: _showReservedServices,
//             ),
//           ],
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             const Text(
//               'Available Services',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ServiceCard(
//               icon: Icons.local_hospital,
//               title: 'Veterinary Care',
//               description:
//                   'Find trusted vets for checkups, vaccinations, and emergencies.',
//               cost: '₹1200',
//               onReserve: (time, contact) {
//                 setState(() {
//                   reservedServices.add({
//                     'service': 'Veterinary Care',
//                     'time': time,
//                     'contact': contact,
//                   });
//                 });
//               },
//             ),
//             ServiceCard(
//               icon: Icons.pets,
//               title: 'Pet Grooming',
//               description:
//                   'Book grooming sessions for your pet’s hygiene and style.',
//               cost: '₹700',
//               onReserve: (time, contact) {
//                 setState(() {
//                   reservedServices.add({
//                     'service': 'Pet Grooming',
//                     'time': time,
//                     'contact': contact,
//                   });
//                 });
//               },
//             ),
//             ServiceCard(
//               icon: Icons.directions_car,
//               title: 'Pet Transport',
//               description: 'Safe and comfortable transport for your pets.',
//               cost: '₹1500',
//               onReserve: (time, contact) {
//                 setState(() {
//                   reservedServices.add({
//                     'service': 'Pet Transport',
//                     'time': time,
//                     'contact': contact,
//                   });
//                 });
//               },
//             ),
//             ServiceCard(
//               icon: Icons.hotel,
//               title: 'Pet Boarding',
//               description:
//                   'Find reliable boarding facilities for your pets when you travel.',
//               cost: '₹900',
//               onReserve: (time, contact) {
//                 setState(() {
//                   reservedServices.add({
//                     'service': 'Pet Boarding',
//                     'time': time,
//                     'contact': contact,
//                   });
//                 });
//               },
//             ),
//             ServiceCard(
//               icon: Icons.school,
//               title: 'Training & Obedience',
//               description: 'Professional trainers for behavior and obedience.',
//               cost: '₹1800',
//               onReserve: (time, contact) {
//                 setState(() {
//                   reservedServices.add({
//                     'service': 'Training & Obedience',
//                     'time': time,
//                     'contact': contact,
//                   });
//                 });
//               },
//             ),
//             const SizedBox(height: 30),
//             const Text(
//               'More services coming soon!',
//               style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ServiceCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String description;
//   final String cost;
//   final void Function(String time, String contact)? onReserve;

//   const ServiceCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.description,
//     required this.cost,
//     this.onReserve,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 14),
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       color: const Color(0xFFF6FFF8),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           final _formKey = GlobalKey<FormState>();
//           final TextEditingController dateController = TextEditingController();
//           final TextEditingController contactController =
//               TextEditingController();
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 backgroundColor: const Color(0xFFF6FFF8),
//                 title: Row(
//                   children: [
//                     Icon(icon, color: const Color(0xFF0E4839), size: 28),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         'Book $title',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 content: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.shade200,
//                               blurRadius: 4,
//                             ),
//                           ],
//                         ),
//                         child: TextFormField(
//                           controller: dateController,
//                           readOnly: true,
//                           decoration: const InputDecoration(
//                             labelText: 'Preferred Date',
//                             hintText: 'Select a date',
//                             border: InputBorder.none,
//                             prefixIcon: Icon(
//                               Icons.calendar_today,
//                               color: Color(0xFF0E4839),
//                             ),
//                           ),
//                           style: const TextStyle(fontSize: 16),
//                           onTap: () async {
//                             DateTime? picked = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime.now(),
//                               lastDate: DateTime.now().add(
//                                 const Duration(days: 365),
//                               ),
//                               builder: (context, child) {
//                                 return Theme(
//                                   data: Theme.of(context).copyWith(
//                                     colorScheme: const ColorScheme.light(
//                                       primary: Color(0xFF0E4839),
//                                       onPrimary: Colors.white,
//                                       surface: Color(0xFFF6FFF8),
//                                       onSurface: Color(0xFF0E4839),
//                                     ),
//                                     textButtonTheme: TextButtonThemeData(
//                                       style: TextButton.styleFrom(
//                                         foregroundColor: Color(0xFF0E4839),
//                                       ),
//                                     ),
//                                   ),
//                                   child: child!,
//                                 );
//                               },
//                             );
//                             if (picked != null) {
//                               dateController.text =
//                                   '${picked.day}/${picked.month}/${picked.year}';
//                             }
//                           },
//                           validator: (value) => value == null || value.isEmpty
//                               ? 'Please select a date'
//                               : null,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.shade200,
//                               blurRadius: 4,
//                             ),
//                           ],
//                         ),
//                         child: TextFormField(
//                           controller: contactController,
//                           decoration: const InputDecoration(
//                             labelText: 'Contact Details',
//                             hintText: 'Phone or Email',
//                             border: InputBorder.none,
//                             prefixIcon: Icon(
//                               Icons.person,
//                               color: Color(0xFF0E4839),
//                             ),
//                           ),
//                           style: const TextStyle(fontSize: 16),
//                           validator: (value) => value == null || value.isEmpty
//                               ? 'Please enter contact details'
//                               : null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Color(0xFF0E4839)),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0E4839),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 10,
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         Navigator.pop(context);
//                         if (onReserve != null) {
//                           onReserve!(
//                             dateController.text,
//                             contactController.text,
//                           );
//                         }
//                         showGeneralDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           barrierLabel: 'Reservation',
//                           pageBuilder: (context, anim1, anim2) {
//                             return ReservationConfirmDialog(
//                               timeSlot: dateController.text,
//                               contact: contactController.text,
//                             );
//                           },
//                         );
//                       }
//                     },
//                     child: const Text(
//                       'Confirm',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF0E4839),
//                   borderRadius: BorderRadius.circular(14),
//                   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Icon(icon, color: Colors.white, size: 32),
//               ),
//               const SizedBox(width: 18),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF0E4839),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       description,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         color: Color(0xFF3A6351),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF3A6351),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   cost,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reservation_confirm_dialog.dart';

// Global list to persist reservations in memory
List<Map<String, String>> reservedServices = [];

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  
  // Show the list of reserved services
  void _showReservedServices() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('My Reserved Services', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF0E4839))),
          content: reservedServices.isEmpty
              ? Text('No reservations yet.', style: GoogleFonts.poppins())
              : SizedBox(
                  width: 300,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: reservedServices.length,
                    separatorBuilder: (_,__) => const Divider(height: 20),
                    itemBuilder: (context, index) {
                      final res = reservedServices[index];
                      final isVet = res['service'] == 'Veterinary Care';
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.bookmark, color: Color(0xFF0E4839)),
                        ),
                        title: Text(res['service'] ?? '', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                          'Time: ${res['time'] ?? ''}\nContact: ${res['contact'] ?? ''}',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                        trailing: isVet
                            ? IconButton(
                                icon: const Icon(Icons.location_on, color: Color(0xFFEF6C00)),
                                tooltip: 'Find Vets Near Me',
                                onPressed: () async {
                                  final url = Uri.parse('https://maps.app.goo.gl/AJSrNCb4iGc1jmgG9');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                  }
                                },
                              )
                            : null,
                      );
                    },
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }

  // Logic to add a reservation to the list
  void _addReservation(String serviceName, String time, String contact) {
    setState(() {
      reservedServices.add({
        'service': serviceName,
        'time': time,
        'contact': contact,
      });
    });
  }

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
          'Pet Services',
          style: GoogleFonts.poppins(
            color: const Color(0xFF0E4839),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Color(0xFF0E4839)),
            tooltip: 'My Reservations',
            onPressed: _showReservedServices,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Professional Care\nFor Your Pet",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0E4839),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Book trusted professionals near you.",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // --- SERVICE CARDS ---
            ServiceCard(
              icon: Icons.local_hospital_outlined,
              title: 'Veterinary Care',
              description: 'Trusted vets for checkups & emergencies.',
              cost: '₹1200',
              onReserve: (t, c) => _addReservation('Veterinary Care', t, c),
            ),
            ServiceCard(
              icon: Icons.content_cut_outlined,
              title: 'Pet Grooming',
              description: 'Spa, bath, and styling sessions.',
              cost: '₹700',
              onReserve: (t, c) => _addReservation('Pet Grooming', t, c),
            ),
            ServiceCard(
              icon: Icons.directions_car_outlined,
              title: 'Pet Transport',
              description: 'Safe pickup & drop services.',
              cost: '₹1500',
              onReserve: (t, c) => _addReservation('Pet Transport', t, c),
            ),
            ServiceCard(
              icon: Icons.bedroom_parent_outlined,
              title: 'Pet Boarding',
              description: 'Cozy stays while you travel.',
              cost: '₹900',
              onReserve: (t, c) => _addReservation('Pet Boarding', t, c),
            ),
            ServiceCard(
              icon: Icons.school_outlined,
              title: 'Training',
              description: 'Behavior and obedience training.',
              cost: '₹1800',
              onReserve: (t, c) => _addReservation('Training & Obedience', t, c),
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                'More services coming soon!',
                style: GoogleFonts.poppins(
                  fontSize: 14, 
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade400
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String cost;
  final Function(String time, String contact)? onReserve;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.cost,
    this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showBookDialog(context),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6FFF8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: const Color(0xFF0E4839), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0E4839),
                            ),
                          ),
                          Text(
                            cost,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFEF6C00),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBookDialog(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Book $title", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF0E4839))),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: "Preferred Date",
                    prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF0E4839)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF0E4839),
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                    }
                  },
                  validator: (v) => v!.isEmpty ? "Select a date" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: contactController,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: "Contact Info",
                    prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF0E4839)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (v) => v!.isEmpty ? "Enter contact info" : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E4839),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  if (onReserve != null) {
                    onReserve!(dateController.text, contactController.text);
                  }
                  
                  // Show Confirmation (Using your existing Dialog widget)
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: "Dismiss",
                    pageBuilder: (context, a1, a2) {
                      return ReservationConfirmDialog(
                        timeSlot: dateController.text,
                        contact: contactController.text,
                      );
                    },
                  );
                }
              },
              child: Text("Confirm Booking", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}