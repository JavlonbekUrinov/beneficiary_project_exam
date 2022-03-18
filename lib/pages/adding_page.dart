import 'dart:io';

import 'package:beneficiary_project_exam/models/model.dart';
import 'package:beneficiary_project_exam/pages/home_page.dart';
import 'package:beneficiary_project_exam/services/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  static const String id = 'add_card_page';

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController reletionShipController = TextEditingController();
  bool isLoading = false;

///////////add mock
  void _apiCreatePost(ModelCard card) async{
    setState(() {
      isLoading = true;
    });
    await Network.POST(Network.API_POST, Network.paramsPost(card)).then((response) {
      print(response);
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      if(response != null) {
        setState(() {
          isLoading = false;
        });
      }

    });
  }
  /////////////add
  void _addCard() {
    if(nameController.text.trim().isNotEmpty && phoneNumberController.text.trim().isNotEmpty && reletionShipController.text.trim().isNotEmpty ) {
      _apiCreatePost(
          ModelCard(nameController.text.trim(), phoneNumberController.text.trim(), reletionShipController.text.trim(), )
      );
      Navigator.pushReplacementNamed(context, CardsPage.id);
    } else {
      print("Please fill all of them");
    }
  }

  void _resAddPost() {
    Navigator.of(context).pop({'data' : 'done'});
  }


  _getImage() async{
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        print('No image selected.');
      }
    });

    isLoading = false;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacementNamed(context, CardsPage.id);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pushReplacementNamed(context, CardsPage.id);
              }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
              Text("Add Recipients",style: TextStyle(color: Colors.black),),
            ],
          ),
          backgroundColor: Colors.white,

        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),

                    GestureDetector(
                        onTap: _getImage,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/girl.png")
                                )
                              ),
                              ) ,
                        )
                    ),

                    const  SizedBox(height: 15,),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: const InputDecoration(
                              labelText: "Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                          // suffix:
                          ),
                        ),
                      ),
                    const  SizedBox(height: 15,),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                              labelText: "Relationship",
                              hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            // suffix:
                          ),
                        ),
                      ),
                    const   SizedBox(height: 15,),



                    Padding(
                      padding: const EdgeInsets.all(8.5),
                      child: IntlPhoneField(
                        controller: reletionShipController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                      ),
                    ),


                    const  SizedBox(height: 15,),


              Align(
                alignment: Alignment.bottomCenter,
                child:       MaterialButton(
                  height: 55,
                  minWidth: MediaQuery.of(context).size.width - 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blueAccent,
                  onPressed: (){
                    _addCard();
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 19,color: Colors.white),),
                ),
              )

                  ],
                ),
              ),
              isLoading ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: CircularProgressIndicator())
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}