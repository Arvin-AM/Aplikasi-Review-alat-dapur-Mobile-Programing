import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference item = FirebaseFirestore.instance.collection(
      'item'); // Mendeklarasikan referensi koleksi 'item' di Firestore

  Stream<QuerySnapshot> getItem() {
    return item
        .snapshots(); // Mengembalikan stream dari hasil snapshot koleksi 'item'
  }

  Stream<QuerySnapshot> getTopRatedItems() {
    return item // Mengembalikan stream dari 5 item dengan rating tertinggi, diurutkan secara descending
        .orderBy('rating',
            descending: true) // Mengurutkan berdasarkan rating tertinggi
        .limit(5) // Membatasi hanya 5 data yang tampil
        .snapshots();
  }
}
