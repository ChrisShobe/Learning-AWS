import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

const FirebaseOptions MyFirebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyA0CBD0ZspPk7Kg25t4-zBpSxWtTpq4GEE",
  authDomain: "aws-practice-6e9e3.firebaseapp.com",
  databaseURL: "https://aws-practice-6e9e3-default-rtdb.firebaseio.com",
  projectId: "aws-practice-6e9e3",
  storageBucket: "aws-practice-6e9e3.appspot.com",
  messagingSenderId: "461228697813",
  appId: "1:461228697813:web:e62af2c24b79c8d6a25a5c",
  measurementId: "G-JM7GP4WVPY",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: MyFirebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  // Define a reference to the Firebase Realtime Database
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  // Function to add name to Firebase
  void _submitName() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;

      ref.child("users").push().set({"name": name}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Name added to database!")),
        );
        _nameController.clear(); // Clear the input field
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add name: $error")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitName,
                child: Text("Submit"),
              ),
              SizedBox(height: 20),

              // StreamBuilder to show list of users
              Expanded(
                child: StreamBuilder(
                  stream: ref.child("users").onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final Map<dynamic, dynamic>? usersMap = snapshot.data!.snapshot.value as Map?;
                      if (usersMap == null) {
                        return Text("No users found.");
                      }
                      final List<Map<dynamic, dynamic>> usersList = usersMap.values.map((user) => Map<dynamic, dynamic>.from(user)).toList();
                      
                      return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(usersList[index]["name"] ?? "No name"),
                          );
                        },
                      );
                    }
                    return Text("No data available");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
