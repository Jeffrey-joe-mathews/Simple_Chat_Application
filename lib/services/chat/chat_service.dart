import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  // get insrtance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get inbstance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  /*

  LIst of maps

  [
    {
      'email' : abc@gmail.com
      'id'
    },
    {
      'email' : abc@gmail.com
      'id'
    }
  ]

  */
  Stream<List<Map<String, dynamic>>> getUsersStream () {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();

        // return user of type<Map, dynamic>
        return user;
      }).toList(); 
    });
  }


  // send message
  Future<void> sendMessage(String recieverId, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();


    // create a new message

    
    //construct a chat room id for the two users (sorted to ensure uniqueness)
    

    // add message to the database
  }


  // get messages


}