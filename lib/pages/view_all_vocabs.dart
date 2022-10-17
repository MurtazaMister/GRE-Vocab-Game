
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

/***
 * Displaying all the Vocabs that are 
 */
class ViewVocabs extends StatefulWidget {
  const ViewVocabs({Key? key}) : super(key: key);

  @override
  _ViewVocabsState createState() => _ViewVocabsState();
}

class _ViewVocabsState extends State<ViewVocabs> {

  final CollectionReference _vocabs = FirebaseFirestore.instance.collection("vocab");
  // var first_name, last_name;
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
                  
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 10,bottom: 10),
                        //   child: FloatingActionButton(
                            
                        //     heroTag: documentSnapshot['word'],
                        //     onPressed: () {
                              
                        //       moveToUpdateVocab(context, documentSnapshot['word'].toString(), documentSnapshot['definition'].toString(), documentSnapshot['synonyms'] as List<dynamic>, documentSnapshot['example'].toString());
                        //     },
                        //     backgroundColor: Colors.green,
                        //     child: const Icon(Icons.edit),
                        //   ),
                        // )
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


