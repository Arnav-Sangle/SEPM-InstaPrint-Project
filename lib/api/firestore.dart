import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_print_app/pages/shop_selection_page.dart';
import 'package:insta_print_app/pages/register_page.dart';

class FirestoreServices {

  // fetch from database
  final CollectionReference shop =
      FirebaseFirestore.instance.collection(selectedShop);

  final CollectionReference register =
    FirebaseFirestore.instance.collection(selectedRegister);

  // create
  Future<void> add(String email, String fileName, int pages, bool color, bool sided, bool orientation, int copies) {
    return shop.add({
      'email' : email,
      'timestamp' : Timestamp.now(),
      'document' : fileName,
      'pages' : pages,
      'color' : color,
      'sided' : sided,
      'orientation' : orientation,
      'copies' : copies
    });
  }

  Future<void> addRegister(String email) {
    return register.add({
      'email' : email
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