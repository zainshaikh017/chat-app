// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/controller/sigup_controller.dart';
import 'package:tech_media/utils/utils.dart';
import '../../component/input_text_field.dart';
import '../../component/round_button.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  final _formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final emailfocusnode = FocusNode();

  final passwordfocusnode = FocusNode();
  final namecontroller = TextEditingController();

  final namefocusnode = FocusNode();

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:ChangeNotifierProvider(
            create: (_)=>sigup_controller(),
            child: Consumer<sigup_controller>(
              builder: (context, provider,child){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Wellcome to Zain Chat App',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        'Enter your email address\nto Register your Account',
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
                                  mycontroller: namecontroller,
                                  focusNode: namefocusnode,
                                  onfiledsubmittedvalue: (value) {},
                                  onvalidator: (value) {
                                    return value.isEmpty ? 'enter name' : null;
                                  },
                                  keyboardtype: TextInputType.name,
                                  hint: 'User Name',
                                  obscuretext: false,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                inputtextfield(
                                  mycontroller: emailcontroller,
                                  focusNode: emailfocusnode,
                                  onfiledsubmittedvalue: (value) {
                                    utils.fieldFocus(context, emailfocusnode,
                                        passwordfocusnode);

                                  },
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
                      SizedBox(
                        height: height * .08,
                      ),
                      Round_button(
                        title: 'Sign Up',
                        loading: provider.loading,
                        onpress: () {

                          if(_formkey.currentState!.validate()){
                            provider.signup(
                                context,
                                namecontroller.text,
                                emailcontroller.text,
                                passwordcontroller.text);
                          }

                        },
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text.rich(TextSpan(text: 'Already have an account? ', children: [
                          TextSpan(
                              text: 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(decoration: TextDecoration.underline)),
                        ])),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}
