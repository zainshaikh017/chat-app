// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/component/input_text_field.dart';
import 'package:tech_media/component/round_button.dart';
import 'package:tech_media/controller/login_controller.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final _formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final emailfocusnode = FocusNode();

  final passwordfocusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    emailfocusnode.dispose();
    passwordcontroller.dispose();
    passwordfocusnode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .10,
              ),
              Text(
                'Wellcome to Zain Chat App',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: height * .01,
              ),
              Text(
                'Enter your email address\nto Connect to your Account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: height * .01,
              ),
              Form(
                  key: _formkey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: height * .06, bottom: height * 0.01),
                    child: Column(
                      children: [
                        inputtextfield(
                          mycontroller: emailcontroller,
                          focusNode: emailfocusnode,
                          onfiledsubmittedvalue: (value) {},
                          onvalidator: (value) {
                            return value.isEmpty ? 'enter email' : null;
                          },
                          keyboardtype: TextInputType.emailAddress,
                          hint: 'Email',
                          obscuretext: false,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        inputtextfield(
                          mycontroller: passwordcontroller,
                          focusNode: passwordfocusnode,
                          onfiledsubmittedvalue: (value) {},
                          onvalidator: (value) {
                            return value.isEmpty ? 'enter password' : null;
                          },
                          keyboardtype: TextInputType.visiblePassword,
                          hint: 'Password',
                          obscuretext: true,
                        ),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.forgetpassword);
                    },
                  child: Text('Forget Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline)),
                ),
              ),
              SizedBox(
                height: height * .08,
              ),
             ChangeNotifierProvider(
                 create:(_)=> logincontroller(),
               child: Consumer<logincontroller>(
                 builder: (context,provider,child){
                   return  Round_button(
                     title: 'Login',
                     loading: provider.loading,
                     onpress: () {
                       if(_formkey.currentState!.validate()){

                         provider.login(context, emailcontroller.text, passwordcontroller.text);


                       }

                     },
                   );
                 },
               ),
             ),
              SizedBox(
                height: height * .03,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RouteName.signupscreen);

                },
                child: Text.rich(TextSpan(text: "Don't have an account? ", children: [
                  TextSpan(
                      text: 'Signup',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline)),
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

