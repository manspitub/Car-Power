

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List>getCars() async {
  
  List cars = [];
  CollectionReference collectionReferenceCars = db.collection('cars');

  QuerySnapshot queryCars = await collectionReferenceCars.get();

  queryCars.docs.forEach((element) {
    cars.add(element.data());
  });


  return cars;

}