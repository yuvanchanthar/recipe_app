import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_application/provider/auth_provider.dart';
import 'package:recipe_application/screens/all_recipe.dart';
import 'package:recipe_application/screens/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final usernameController=TextEditingController();
  final passwordController=TextEditingController();

  // @override void initState() {
    
  //   super.initState();
   
  // }
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthProvider>(context);
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
                const Text("Username"),
                const SizedBox(height: 6,),
                
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
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
              child: auth.isLoading 
              ? const CircularProgressIndicator():
               ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: ()async{
                  bool success= await auth.login(
                    usernameController.text, passwordController.text);
                    if(success ){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AllRecipePage()));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed")));
                    }
                 
                 
                }, child: Text("Sign In",
                style: TextStyle(fontSize: 18),),),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New Member?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpPage()));
                    }, child: Text("Sign Up",
                    style: TextStyle(color: Colors.green,
                    fontWeight: FontWeight.bold),))

                  ],
                ),
              )
            ],),),
            // ElevatedButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (_)=>AllRecipePage()));
            // }, child: Text("All recipe page")),

          ],
        ),
      ),
      
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