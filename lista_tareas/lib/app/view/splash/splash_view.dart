//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lista_tareas/app/view/components/h1.dart';
import 'package:lista_tareas/app/view/components/shape.dart';
import 'package:lista_tareas/app/view/home/inherited_widgets.dart';
import 'package:lista_tareas/app/view/register/register.dart';
//import 'package:lista_tareas/app/view/components/shape.dart';
import 'package:lista_tareas/app/view/task_list/task_list_view.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [Shape()],
            ),
            const SizedBox(
              height: 79,
            ),
            Image.asset(
              'assets/images/celular.png',
              width: 250,
              height: 200,
            ),
            const SizedBox(
              height: 99,
            ),
            const H1(
              'Lista de tareas',
            ),
            Text(
              'Vamos a guardar tareas',
              style: TextStyle(color: SpecialColor.of(context).color),
            ),
            const SizedBox(
              height: 21,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const TaskListView();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StatePage()));
              },
              child: const Text('Registrate'),
            ),
            //const SizedBox(
            //height: 30,
            //),
            //ElevatedButton(
            //onPressed: () async {
            //const url = 'https://docs.flutter.dev/tos';

            //if (await canLaunch(url)) {
            //await launch(url);
            //}
            //},
            //child: const Text(
            //'Términos y condiciones',
            //),
            //),
          ],
        ),
      ),
    );
  }
}
