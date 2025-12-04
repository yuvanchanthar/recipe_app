import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final usernameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.green.shade300,
              ),
            ),
            const SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Hi there!",
              style: TextStyle(fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green),),
              const SizedBox(height: 4,),
              Text('Welcome back.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
              ),


              ],
            ),
            ),
            const SizedBox(height: 25,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   const   SizedBox(height: 20,),
              const Text("Username"),
              const SizedBox(height: 6),
              TextField(
                controller: usernameController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Username",
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),
              const SizedBox(height: 6,),
                const Text("Email"),
                const SizedBox(height: 6,),
                
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "abc123@gmail.com",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green.shade300),
                  ),
                  
                ),
              ),
              const   SizedBox(height: 20,),
              const Text("Password"),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  ),
                ),
              ),
              const SizedBox(height: 35,),
              SizedBox(width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: (){}, child: Text("Sign Up",
                style: TextStyle(fontSize: 18),),),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a customer"),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Sign In",
                    style: TextStyle(color: Colors.green,
                    fontWeight: FontWeight.bold),))

                  ],
                ),
              )
            ],),)

          ],
        ),
      )
    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override 
  Path getClip(Size size) {
    Path path=Path();
    path.lineTo(0, size.height-40);

    var firstStart= Offset(size.width *0.25, size.height);
    var firstEnd= Offset(size.width * 0.5, size.height-30);

    path.quadraticBezierTo(
      firstStart.dx,
       firstStart.dy,
        firstEnd.dx,
         firstEnd.dy);

    var secondStart=Offset(size.width * 0.75, size.height-60);
    var secondEnd= Offset(size.width, size.height-20);

    path.quadraticBezierTo(
      secondStart.dx,
       secondStart.dy,
        secondEnd.dx,
         secondEnd.dy);

         path.lineTo(size.width, 0);
         path.close();
         return path;


   
    
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
   
   
}