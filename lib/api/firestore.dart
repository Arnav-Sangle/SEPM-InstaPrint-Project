import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_print_app/pages/shop_selection_page.dart';

class FirestoreServices {

  // fetch from database
  final CollectionReference shop =
      FirebaseFirestore.instance.collection(selectedShop);

  // create
  Future<void> add(int pages, bool color) {
    return shop.add({
      'pages' : pages,
      'color' : color,
      'timestamp' : Timestamp.now()
    });
  }

  // read
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = shop.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  // UPDATE: update notes given a doc id
  Future<void> updateNote (String docID, String newNote) {
    return shop.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // delete
  Future<void> deleteNote(String docID) {
    return shop.doc(docID).delete();
  }
}