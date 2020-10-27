import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' show Platform;

class FirestoreService {
  FirestoreService._internal();
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;

  static FirestoreService get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  void initLocal() {
    final _host = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';

    _firestore.settings = Settings(
      host: _host,
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }

  Future<QuerySnapshot> getCollection(String path, [GetOptions options]) async {
    return await _firestore.collection(path).get(options);
  }

  Future<DocumentSnapshot> getDocument(String path,
      [GetOptions options]) async {
    return await _firestore.doc(path).get(options);
  }

  Future<void> setDocument(String path, Map<String, dynamic> data,
      [SetOptions options]) async {
    await _firestore.doc(path).set(data, options);
  }

  Stream<QuerySnapshot> streamCollection(String path) {
    return _firestore.collection(path).snapshots();
  }

  Stream<DocumentSnapshot> streamDocument(String path) {
    return _firestore.doc(path).snapshots();
  }
}
