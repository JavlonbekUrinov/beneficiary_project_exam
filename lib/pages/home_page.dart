import 'package:beneficiary_project_exam/models/model.dart';
import 'package:beneficiary_project_exam/pages/adding_page.dart';
import 'package:beneficiary_project_exam/services/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);
  static const String id = 'cards_page';

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  bool isLoading = false;
  List<ModelCard> cards = [];


  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_GET, Network.paramsEmpty()).then((response) {
      if(response != null) {
        setState(() {
          _showResponse(response);
        });
      } else {
        if (kDebugMode) {
          print("Response is null");
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void _showResponse(String? response) {
    setState(() {
      isLoading = false;
      if (response != null) {
        cards = Network.parseResponse(response);
      }
    });
  }

  @override
  void initState() {
    _apiPostList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Beneficiary', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black45,
                    size: 30,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.black45),
                  labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.transparent)
                  )
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [

          ////////////////////ADD CARD

          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Recipients",style: TextStyle(color: Colors.grey,fontSize: 23,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),

                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                             onDismissed: (_) async{
                               cards.removeAt(index);
                               await Network.DELETE(Network.API_DELETE + cards[index].name,Network.paramsEmpty());
                          },
                            key: Key(cards[index].name),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),

                               child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset("assets/images/girl.png"),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      cards[index].name,
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                  subtitle: Text(
                                    cards[index].relationShip
                                  ),

                                  trailing: MaterialButton(
                                    minWidth: 40,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.blue,
                                    child: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                                    onPressed: (){},
                                  ),
                                )
                            ),
                          );
                        }
                    ),


                  ],
                ),
              ),
              isLoading ?  Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 30,),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AddCardPage.id);
          },),
    );
  }
}