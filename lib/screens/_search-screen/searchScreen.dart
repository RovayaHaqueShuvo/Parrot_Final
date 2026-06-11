import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parrot_messaging/firebase-Database/QuaryUserWithSearch.dart';
import 'package:parrot_messaging/getX/_ScreenManagement/_screenManagement.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Quaryuserwithsearch searchController = Get.put(Quaryuserwithsearch());

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => searchController.searchUsers(value),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white54
                  : Colors.grey.shade600,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.grey.shade700,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),

          child: Text("Search by Email, Phone, UID or Username"),
        ),
      ),
      body: Obx(() {
        if (searchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (searchController.searchResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
                const SizedBox(height: 10),
                Text(
                  "No users found",
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: searchController.searchResults.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            var user = searchController.searchResults[index];
            return ListTile(
              onTap: () {
                // চ্যাটবোর্ড এ যাওয়ার লজিক (MessageTiles এর ফরম্যাট অনুযায়ী)
                Get.toNamed(
                  Routes.chatBoardScreen,
                  arguments: {
                    'UID': user['uid'] ?? '',
                    'NAME': user['name'] ?? 'Unknown',
                    'EMAIL': user['email'] ?? '',
                    'PHOTO_URL': user['photoUrl'] ?? '',
                  },
                );
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: user['photoUrl'] != null && user['photoUrl'].toString().isNotEmpty
                    ? NetworkImage(user['photoUrl'])
                    : const AssetImage("assets/parrot.png") as ImageProvider,
              ),
              title: Text(
                user['name'] ?? "No Name",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                user['username'] ?? user['email'] ?? "No Details",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right),
            );
          },
        );
      }),
    );
  }
}
