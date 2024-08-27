import 'package:flutter/material.dart';

import 'api.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  SchoolScreenState createState() => SchoolScreenState();
}

class SchoolScreenState extends State<SchoolScreen> {
  Future<List<dynamic>>? schools;

  @override
  void initState() {
    super.initState();
    schools = BlueArchiveApi.fetchSchools();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: schools,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No schools found'));
          } else {
            print('School data: ${snapshot.data}'); // Debug print
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var school = snapshot.data![index];
                return ListTile(
                  title: Text(school['name']),
                  onTap: () {
                    // Handle school tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
