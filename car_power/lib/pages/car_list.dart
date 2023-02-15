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
                    Color colors;
                    if(snapshot.data?[index]['Especial']){
                      colors = Colors.greenAccent;
                    } else {
                      colors = Colors.white;
                    }
                    return GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, '/edit', arguments: {
                          "Marca": snapshot.data?[index]['Marca'],
                          "Descripcion": snapshot.data?[index]['Descripcion'],
                          "Precio": snapshot.data?[index]['Precio'],
                          "Year": snapshot.data?[index]['Year'],
                          "Caballos": snapshot.data?[index]['Caballos'],
                          "Especial": snapshot.data?[index]['Especial'],

                        });
                      }),
                      child: Dismissible(
                        
                          key: Key(snapshot.data?[index]['Marca']),
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              snapshot.data!.removeAt(index);
                            });
                          },
                          direction: DismissDirection.endToStart,
                          child: Card(
                            color: colors,
                            elevation: 5,
                            child: Container(
                              height: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://www.autobild.es/sites/autobild.es/public/styles/main_element/public/dc/fotos/Audi_S8_01.jpeg?itok=YTYpxpEW"))),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(snapshot.data?[index]['Marca'], style: TextStyle(fontWeight: FontWeight.bold),),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 3),
                                            child: Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.yellow),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10))),
                                              child: Text(
                                                (snapshot.data?[index]['Precio']).toString()+ '€',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(0, 5, 0, 2),
                                                  child: Container(
                                                    width: 260,
                                                    child: Text(snapshot.data?[index]["Descripcion"], style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(255, 48, 48, 54),
                                                      
                                                    ),),
                                                  )
                                          )],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
          await Navigator.pushNamed(context, '/add');
          setState(() {});
          },
          child: const Icon(Icons.add),),
        
        );
  }
}
