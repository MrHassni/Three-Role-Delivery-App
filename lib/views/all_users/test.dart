import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

  bool pass=true;

  bool confirmPass=true;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  child: const Text("Registrieren",)),

              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: size.height * 0.725,
                    width: size.width,
                    padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Willkommen zuruck!",style: TextStyle(color: Colors.black,fontSize: 20)),
                        Text("Logge dich mit deinen Benutzerdaten ein", style: TextStyle(color: Colors.black,fontSize: 16)),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              height:60,
                              padding:EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.email_outlined,color: Colors.white,size: 30,),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              fit: FlexFit.loose,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    label: Text("E-MAIL",)
                                ),

                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              height:60,
                              padding:EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.lock_outline,color: Colors.white,size: 30,),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              fit: FlexFit.loose,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                                obscureText: pass,
                                decoration: InputDecoration(
                                  label: Text("PASSWORT"),
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(pass==true){
                                            pass=false;
                                          }else{
                                            pass=true;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.remove_red_eye_outlined,)),
                                ),
                                validator: (PassCurrentValue){
                                  RegExp regex=RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$');
                                  var passNonNullValue=PassCurrentValue??"";
                                  if(passNonNullValue.isEmpty){
                                    return ("Password is required");
                                  }
                                  else if(passNonNullValue.length < 8){
                                    return ("Password Must be more than 8 characters");
                                  }
                                  else if(!regex.hasMatch(passNonNullValue)){
                                    return ("Password should contain upper,lower and Special character");
                                  }
                                  return null;
                                },
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              height:60,
                              padding:EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.lock_outline,color: Colors.white,size: 30,),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              fit: FlexFit.loose,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: confirmPass,
                                decoration: InputDecoration(
                                  label: Text("Passwort Wiederholen"),
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(confirmPass==true){
                                            confirmPass=false;
                                          }else{
                                            confirmPass=true;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.remove_red_eye_outlined,color: Colors.black,)),
                                ),
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Conform password required';
                                  }
                                  if(value != passwordController.text){
                                    return 'Confirm password not matching';
                                  }
                                  return null;
                                },

                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 70,),
                        MaterialButton(child:Text("Registrieren"),onPressed: (){
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          _formKey.currentState!.save();

                          Navigator.pushNamed(context, "/finishRegistrationScreen");
                        },),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          child: Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Indem Sie fortfahren, erklaren Sie sich mit den Share A Lot",
                                    children: [
                                      TextSpan(
                                          text: " Geschäftsbedingungen",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                              decoration: TextDecoration.none,
                                              decorationThickness: 2,
                                              decorationStyle: TextDecorationStyle.solid
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap=(){}
                                      ),
                                      TextSpan(
                                        text: " und der ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: " Datenschutzrichtlinie",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              // color: kBlueColor,
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline,
                                              decorationThickness: 2,
                                              decorationStyle: TextDecorationStyle.solid
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap=(){}
                                      ),
                                      TextSpan(
                                        text: " einverstanden",
                                        style: TextStyle(
                                            // color: kBlackColor
                                            color: Colors.black

                                        ),
                                      ),
                                    ],
                                    style: TextStyle(
                                      // color: kBlackColor
                                        color: Colors.black),
                                  ))),
                        ),

                        IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Sie haben bereits einen Account? ",style: TextStyle(color: Colors.black,fontSize: 14)),
                                      TextButton(
                                         child: Text( 'Einloggen'),onPressed: (){

                                      }),
                                    ],
                                  )),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}