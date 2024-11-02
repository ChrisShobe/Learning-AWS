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
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  
  String? selectedKey;

  void _submitName() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;

      ref.child("users").push().set({"name": name}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Name added to database!")),
        );
        _nameController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add name: $error")),
        );
      });
    }
  }

  void _deleteName() {
    if (selectedKey != null) {
      ref.child("users/$selectedKey").remove().then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Name deleted from database!")),
        );
        setState(() {
          selectedKey = null; // Clear the selected key
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete name: $error")),
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
              Container(
                width: 1535,
                height: 1171,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFF868686)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 93,
                      top: 232,
                      child: SizedBox(
                        width: 1388,
                        height: 207,
                        child: Text(
                          'Please Enter Your Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 120,
                            fontFamily: 'Irish Grover',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 217,
                      top: 492,
                      child: Container(
                        width: 1101,
                        height: 187,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 54,
                      top: 56,
                      child: Container(
                        width: 39,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 1422,
                      top: 56,
                      child: Container(
                        width: 39,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 1422,
                      top: 1047,
                      child: Container(
                        width: 39,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 54,
                      top: 1047,
                      child: Container(
                        width: 39,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 491,
                      top: 814,
                      child: Container(
                        width: 552,
                        height: 180,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 635,
                      top: 857,
                      child: SizedBox(
                        width: 354,
                        height: 94,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 90,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
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

                      final List<MapEntry<dynamic, dynamic>> usersList = usersMap.entries.toList();

                      return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          final userKey = usersList[index].key;
                          final userName = usersList[index].value["name"];
                          return ListTile(
                            title: Text(userName ?? "No name"),
                            selected: userKey == selectedKey,
                            onTap: () {
                              setState(() {
                                selectedKey = userKey;
                              });
                            },
                          );
                        },
                      );
                    }
                    return Text("No data available");
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: selectedKey != null ? _deleteName : null,
                child: Text("Delete Selected"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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