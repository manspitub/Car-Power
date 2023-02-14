import 'package:car_power/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({Key? key}) : super(key: key);

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  Image getBackground() {
    return Image.asset("assets/fondo_coche.jpeg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    Text('Car Power',
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
        body: FutureBuilder(
          future: getCars(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                      return Text(snapshot.data?[index]['Marca']);

                });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
