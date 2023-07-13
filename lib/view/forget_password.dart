import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/controller/forgetpasswordcontroller.dart';

import '../component/input_text_field.dart';
import '../component/round_button.dart';
import '../controller/login_controller.dart';
import '../utils/routes/route_name.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);

  @override
  State<forget_password> createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  final _formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

  final emailfocusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    emailfocusnode.dispose();
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
                'Enter your email address\nto recover your account',
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
                      ],
                    ),
                  )),
              SizedBox(
                height: height * .03,
              ),
              ChangeNotifierProvider(
                create:(_)=> forgetpasswordcontroller(),
                child: Consumer<forgetpasswordcontroller>(
                  builder: (context,provider,child){
                    return  Round_button(
                      title: 'Forget',
                      loading: provider.loading,
                      onpress: () {
                        if(_formkey.currentState!.validate()){

                          provider.forgetpassword(context, emailcontroller.text,);


                        }

                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
