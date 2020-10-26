import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forest_guard/services/firestore_service.dart';

class AuthService {
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  static AuthService get instance => _instance;

  final _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot> _getAgentDoc(String agentID) async {
    final snapshots = await FirestoreService.instance.getCollection(
      'agents',
      GetOptions(source: Source.server),
    );

    for (var doc in snapshots.docs) {
      if (doc.data()['agent_id'] == agentID) {
        return doc;
      }
    }

    return null;
  }

  User get currentUser => _auth.currentUser;

  Future<User> login(String agentID, String forestID) async {
    try {
      final doc = await _getAgentDoc(agentID);

      if (doc != null) {
        final result = await _auth.signInAnonymously();

        return result.user;
      }

      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
