
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gre_dictionary_game/Models/Word.dart';
import 'package:gre_dictionary_game/pages/add_vocab.dart';
import 'package:gre_dictionary_game/pages/update_vocab.dart';
import 'package:gre_dictionary_game/pages/view_vocab.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'View Users',
      home: ViewVocabs(),
    );
  }
}

class ViewVocabs extends StatefulWidget {
  const ViewVocabs({Key? key}) : super(key: key);

  @override
  _ViewVocabsState createState() => _ViewVocabsState();
}

class _ViewVocabsState extends State<ViewVocabs> {

  final CollectionReference _vocabs = FirebaseFirestore.instance.collection("vocab");
  
  /// This function will be used to redirect to the edit vocab page so that users can add new information or remove unnecessary info about the vocab. This function accepts all the arguments for the vocab such as - [word], [definition], [synonyms], and [example]
  moveToUpdateVocab(BuildContext context, String word, String definition, List<dynamic> synonyms, String example) async {
    
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => UpdateVocab(
        o_word: word,
        o_definition: definition,
        o_synonyms: synonyms,
        o_example: example,
      )));
    
  }

  /// This function will redirect the user to the create page of vocabs where a user can add a new vocab into the database of GRE vocabs
   moveToAddVocab(BuildContext context) async {
    
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => AddVocab(),
      ));  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _vocabs.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if(streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

                return Card(
                  
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewVocab(word: documentSnapshot['word'].toString(), definition: documentSnapshot['definition'].toString(), synonyms: documentSnapshot['synonyms'] as List<dynamic>, example: documentSnapshot['example'].toString())));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          title: Text(documentSnapshot['word']),
                          subtitle: Text(documentSnapshot['definition'].toString()),
                        ),
                    ],),
                  )
                  
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
        floatingActionButton: FloatingActionButton(  
          
        child: Icon(Icons.add_circle),  
        backgroundColor: Colors.green,  
        foregroundColor: Colors.white,  
        onPressed: () => {
          moveToAddVocab(context),

        },  
      ),  
    );
  }
}


