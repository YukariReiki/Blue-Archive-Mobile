import 'package:flutter/material.dart';
import 'api.dart';
import 'character_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterScreen extends StatefulWidget {
  @override
  CharacterScreenState createState() => CharacterScreenState();
}

class CharacterScreenState extends State<CharacterScreen> {
  Future<List<dynamic>>? characters;
  List<String> favoriteIds = [];
  String selectedSchool = 'All'; // Filter school
  String sortBy = 'Name'; // Sorting criteria

  @override
  void initState() {
    super.initState();
    characters = BlueArchiveApi.fetchCharacters();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteIds = prefs.getStringList('favoriteIds') ?? [];
    });
  }

  Future<void> _toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteIds.contains(id)) {
        favoriteIds.remove(id);
      } else {
        favoriteIds.add(id);
      }
      prefs.setStringList('favoriteIds', favoriteIds);
    });
  }

  List<dynamic> _filterAndSortCharacters(List<dynamic> characters) {
    List<dynamic> filteredCharacters = selectedSchool == 'All'
        ? characters
        : characters.where((char) => char['school'] == selectedSchool).toList();

    if (sortBy == 'Name') {
      filteredCharacters.sort((a, b) => a['name'].compareTo(b['name']));
    } else if (sortBy == 'School') {
      filteredCharacters.sort((a, b) => a['school'].compareTo(b['school']));
    }

    return filteredCharacters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the end
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Filter Dropdown Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: DropdownButton<String>(
                          value: selectedSchool,
                          items: <String>[
                            'All',
                            'Trinity',
                            'Millennium',
                            'Gehenna',
                            'Abydos',
                            'Red Winter',
                            'Hyakkiyako',
                            'Arius'
                          ]
                              .map((school) => DropdownMenuItem<String>(
                                    value: school,
                                    child: Text(school),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSchool = value!;
                            });
                          },
                        ),
                      ),
                      // Sorting Dropdown Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: DropdownButton<String>(
                          value: sortBy,
                          items: <String>['Name', 'School']
                              .map((criteria) => DropdownMenuItem<String>(
                                    value: criteria,
                                    child: Text(criteria),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              sortBy = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: characters,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No characters found'));
                } else {
                  final filteredAndSortedCharacters = _filterAndSortCharacters(snapshot.data!);

                  return ListView.builder(
                    itemCount: filteredAndSortedCharacters.length,
                    itemBuilder: (context, index) {
                      final character = filteredAndSortedCharacters[index];
                      return ListTile(
                        leading: character['photoUrl'] != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(character['photoUrl']),
                              )
                            : CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                        title: Text(character['name']),
                        subtitle: Text(character['school']),
                        trailing: IconButton(
                          icon: Icon(
                            favoriteIds.contains(character['_id'])
                                ? Icons.star
                                : Icons.star_border,
                          ),
                          onPressed: () => _toggleFavorite(character['_id']),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharacterDetailScreen(character: character),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
