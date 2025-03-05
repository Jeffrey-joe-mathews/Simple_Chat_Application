import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat_app/models/message.dart';

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
  Future<void> sendMessage(String recieverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();


    // create a new message
    Message newMessage = Message(
        senderID: currentUserEmail, 
        senderEmail: currentUserID, 
        recieverID: recieverID, 
        message: message, 
        timestamp: timeStamp
      );

    
    //construct a chat room id for the two users (sorted to ensure uniqueness)

    List<String> ids = [currentUserID, recieverID] ;
    ids.sort(); // this ensures that any two peopkle in the chatroom has rthe same ID
    String chatRoomID = ids.join("_");

    // add message to the database

    await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());
  }


  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroom id for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
  }


}