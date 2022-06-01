

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite_qr/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff3080DB),
              Color(0xff7A0DE7),
            ]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Tu carnet de vacunación",
              style: TextStyle(
                fontSize: 46.0,
                height: 1,
                fontWeight: FontWeight.w900,
                color: Colors.white//Color(0xff2A2B2B),
              ),
              ),
              const SizedBox(height: 12.0,),
              Text("Con esta App, podrás gestionar los carnets de las personas que desees. No olvides ser responsable",
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: Colors.white//Color(0xff2A2B2B),
                ),
              ),
              const SizedBox(height: 12.0,),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff34C31C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    child: Text("Iniciar ahora",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
