import 'dart:io';

import 'package:car_power/services/firebase_service.dart';
import 'package:car_power/services/select_image.dart';
import 'package:car_power/services/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  TextEditingController marcaController = TextEditingController(text: "");
  TextEditingController descripcionController = TextEditingController(text: "");
  TextEditingController caballosController = TextEditingController(text: "");
  TextEditingController precioController = TextEditingController(text: "");
  TextEditingController especialController = TextEditingController(text: "");
  TextEditingController yearController = TextEditingController(text: "");

  File? imagen_to_upload;

  @override
  Widget build(BuildContext context) {
    var isEspecial = false;
    especialController.text = isEspecial.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    fit: BoxFit.scaleDown,
                    height: 50,
                    image: AssetImage('assets/coche_icono.png'),
                  ),
                  SizedBox(width: 10),
                  Text('Crea un coche',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              controller: marcaController,
              decoration: InputDecoration(
                  hintText: 'Ingrese la marca',
                  prefixIcon: Icon(
                    Icons.car_repair_rounded,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: "MARCA",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
            ),
            TextField(
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              controller: descripcionController,
              decoration: InputDecoration(
                  hintText: 'Ingrese la descripción',
                  prefixIcon: Icon(
                    Icons.description,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: "DESCRIPCION",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              controller: precioController,
              decoration: InputDecoration(
                  hintText: 'Ingrese el precio',
                  prefixIcon: Icon(
                    Icons.money,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: "PRECIO",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              controller: yearController,
              decoration: InputDecoration(
                  hintText: 'Ingrese el año',
                  prefixIcon: Icon(
                    Icons.numbers_rounded,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: "AÑO",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              controller: caballosController,
              decoration: InputDecoration(
                  hintText: 'Ingrese los caballos',
                  prefixIcon: Icon(
                    Icons.speed,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: "CABALLOS",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
            ),
            SwitchListTile(
              value: isEspecial,
              onChanged: (value){
                setState(() {
                  isEspecial = value;
                });
                especialController.text = value.toString();
              },

              title: Text("Especial?"),
              secondary: Icon(Icons.brightness_medium),
              ),
              Row(
                children: [

                  imagen_to_upload !=null ? 
                  Image.file(imagen_to_upload!, fit: BoxFit.fill, width: 140) :Container(
                    margin: const EdgeInsets.all(10),
                    height: 80,
                    width: 140,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      final image = await getImageFromGallery();
                      setState(() {
                        imagen_to_upload = File(image!.path);
                      });
                    }, 
                     child: Icon(Icons.image)),
                ],
              ),
                
            ElevatedButton(
                onPressed: () async {
                  if(imagen_to_upload == null){
                    return;
                  } 

                  final uploaded = await uploadImage(imagen_to_upload!);


                  await addCar(marcaController.text, int.parse(caballosController.text), descripcionController.text, isEspecial, int.parse(precioController.text), int.parse(yearController.text), ).then((value) => Navigator.pop(context));
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
