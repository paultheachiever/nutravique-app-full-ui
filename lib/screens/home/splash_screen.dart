
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState()=> _SplashScreenState();
}

class _SplashScreenState extends
State<SplashScreen>{
  @override
  void initState(){
    super.initState();

  Future.delayed(const Duration(seconds: 4), (){
    Navigator.pushReplacementNamed(context, '/onboarding');

  });

  }
  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/images/homepage.jpg',
        fit: BoxFit.cover,),
          
                ),
    );
    
  }
}