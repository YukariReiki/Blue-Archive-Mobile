import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> character;

  CharacterDetailScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: character['photoUrl'] != null
                  ? ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4), // Menambahkan border
                        ),
                        child: Image.network(
                          character['photoUrl'],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Icon(Icons.person, size: 200),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Name:', character['name']),
            const SizedBox(height: 8),
            _buildDetailRow('Birthday:', character['birthday']),
            const SizedBox(height: 8),
            _buildDetailRow('Damage Type:', character['damageType']),
            const SizedBox(height: 16),
            _buildSchoolRow(character['imageSchool'], character['school']),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun baris detail
  Widget _buildDetailRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value ?? 'Not Available',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk membangun baris sekolah
  Widget _buildSchoolRow(String? imageSchool, String? schoolName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'School: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (imageSchool != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.network(
              imageSchool,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              height: 40,
              width: 40,
              color: Colors.grey,
              child: Center(child: Icon(Icons.image, color: Colors.white)),
            ),
          ),
        Text(
          schoolName ?? 'Unknown School',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
