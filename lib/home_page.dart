import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Referencia a la caja
  final _myBox = Hive.box('mybox');

  //Write
  void writeUser() {
    @override
    Widget build(BuildContext context) {
      TextEditingController _controller = TextEditingController();

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Ingresa tu nombre de usuario.',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  // Do something with the entered text
                  _myBox.put(1, _controller.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  //Read
  void writeEmail() {
    @override
    Widget build(BuildContext context) {
      TextEditingController _controller = TextEditingController();

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Ingresa tu email.',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  // Do something with the entered text
                  _myBox.put(2, _controller.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  //Datos
  void showData() {
    @override
    Widget build(BuildContext context) {
      var box = Hive.box('myBox');

      return Scaffold(
        appBar: AppBar(
          title: const Text('Hive Data Page'),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return const Center(
                child: Text('No hay datos disponibles.')
                );
            } 
            else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  var key = box.keyAt(index);
                  var value = box.get(key);
                  return ListTile(
                    title: Text('Key: $key'),
                    subtitle: Text('Value: $value'),
                  );
                },
              );
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: writeUser,
              child: Text('Usuario'),
              color: Colors.blue,
              ),
            MaterialButton(
              onPressed: writeEmail,
              child: Text('eMail'),
              color: Colors.blue,
              ),
            MaterialButton(
              onPressed: showData,
              child: Text('Datos'),
              color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
