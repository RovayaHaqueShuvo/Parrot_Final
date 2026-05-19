import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

/// SECTION TITLE
Widget sectionTitle(String title) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

    child: Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        letterSpacing: 1,
      ),
    ),
  );
}

/// SETTINGS TILE
Widget settingsTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  bool trailingSwitch = false,
}) {
  return Container(
    color: Colors.white,

    child: ListTile(
      leading: Icon(icon, color: iconColor),

      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),

      trailing:
          trailingSwitch
              ? Switch(
                value: false,
                onChanged: (value) {},
                activeColor: Colors.green,
              )
              : const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
    ),
  );
}
