

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

Future<void> addCar(String marca, int caballos, String descripcion, bool especial, int precio, int year) async {
  await db.collection("cars").add({"Marca": marca, "Descripcion": descripcion, "Caballos": caballos, "Especial": especial, "Precio": precio, "Year": year});
}

Future<void> updateCar(String uid, String newMarca, int newCaballos, String newDescripcion, bool newEspecial, int newPrecio, int newYear) async {
  await db.collection("cars").doc(uid).set({"Marca": newMarca, "Descripcion": newDescripcion, "Caballos": newCaballos, "Especial": newEspecial, "Precio": newPrecio, "Year": newYear});
}