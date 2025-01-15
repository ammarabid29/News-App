import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class DBCollections {
  static CollectionReference users = _firebaseFirestore.collection("users");
}
