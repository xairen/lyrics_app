import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'song.dart';
import 'dart:html' as html;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDLRCmhdttAPK6i_PUb_5mKna-9_0McbHU",
          appId: "1:336859955085:web:91d3ec2e8dfd31094d47c4",
          messagingSenderId: "336859955085",
          projectId: "lyrics-549d3"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    ProjectsPage(),
    LyricsEditorPage(
      songId: '1QEf44xlN4eF4ZTPZARi',
    ),
    FileUploadPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lyrics Manager'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Lyrics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Upload MP3',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example project list
    final List<String> projects = ["Song 1", "Song 2", "Song 3"];

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(projects[index]),
          onTap: () {
            // Navigate to LyricsEditorPage with project info
          },
        );
      },
    );
  }
}

class LyricsEditorPage extends StatefulWidget {
  final String songId;

  LyricsEditorPage({required this.songId});

  @override
  _LyricsEditorPageState createState() => _LyricsEditorPageState();
}

class _LyricsEditorPageState extends State<LyricsEditorPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLyrics();
  }

  void _loadLyrics() async {
    // Load lyrics from local storage or a backend service
    final doc = await FirebaseFirestore.instance
        .collection('songs')
        .doc(widget.songId)
        .get();
    _controller.text = doc['lyrics'] ?? '';
  }

  void _saveLyrics() async {
    // Save lyrics to local storage or a backend service
    await FirebaseFirestore.instance
        .collection('songs')
        .doc(widget.songId)
        .update({
      'lyrics': _controller.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null, // makes it expandable
              decoration: InputDecoration(
                hintText: 'Enter your lyrics here...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveLyrics,
            child: Text('Save Lyrics'),
          ),
        ],
      ),
    );
  }
}

class FileUploadPage extends StatelessWidget {
  void _uploadFile() {
    final uploadInput = html.FileUploadInputElement()..accept = '.mp3';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file!); // Read the file

      reader.onLoadEnd.listen((event) {
        // Upload file content somewhere, e.g., to your server
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _uploadFile,
        child: Text('Upload MP3'),
      ),
    );
  }
}
