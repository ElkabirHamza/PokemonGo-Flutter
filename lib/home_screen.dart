import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke/detail_screen.dart';



class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState () => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  var pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late List Pokedex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetchPokemonDate();
    }
  }

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height ;
    return Scaffold(

        body: Stack(
          children: [
            Positioned(
              top: 150,
              bottom: 0,
              width: width,
              child: Column(

              ),
            ),
            Pokedex.length != null ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4
            ), itemCount: Pokedex.length,
              itemBuilder: (context,index){
                var type = Pokedex[index]['type'][0];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                  child: InkWell(
                  child: SafeArea(
                  child:Container(
                    decoration: BoxDecoration(

                      color: Pokedex[index]['type'][0] == "Grass" ? Colors.greenAccent : Pokedex[index]['type'][0] == "Fire" ? Colors.redAccent
                          : Pokedex[index]['type'][0] == "Water" ? Colors.blue : Pokedex[index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                          : Pokedex[index]['type'][0] == "Electric" ? Colors.amber : Pokedex[index]['type'][0] == "Rock" ? Colors.grey
                          : Pokedex[index]['type'][0] == "Ground" ? Colors.brown : Pokedex[index]['type'][0] == "Psychic" ? Colors.indigo
                          : Pokedex[index]['type'][0] == "Fighting" ? Colors.orange : Pokedex[index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                          : Pokedex[index]['type'][0] == "Ghost" ? Colors.deepPurple : Pokedex[index]['type'][0] == "Normal" ? Colors.white70 : Colors.pink,

                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Stack(
                        children: [

                          Positioned(
                              bottom:-10,
                              right: -10,
                              child: Image.asset('images/pokeball.png',
                                height: 100,
                                fit: BoxFit.fitHeight,
                              )
                          ),
                          Positioned(
                            top:10,
                            left: 10,
                            child: Text(
                              Pokedex[index]['name'],

                              style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Positioned(
                            bottom:5,
                            right:5,
                            child: CachedNetworkImage(
                              imageUrl: Pokedex[index]['img'],
                              height: 100,
                              fit:BoxFit.fitHeight,
                            ),


                          ),
                          Positioned(
                            top:45,
                            left:10,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0,right:8.0,top: 4,bottom: 4),
                                child: Text(
                                  type.toString(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.black26,

                              ),
                            ),
                          ),
                        ]
                    ),
                ),
                  ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetailScreen(
                        pokemonDetail: Pokedex[index],
                         color: Pokedex[index]['type'][0] == "Grass" ? Colors.greenAccent : Pokedex[index]['type'][0] == "Fire" ? Colors.redAccent
                          : Pokedex[index]['type'][0] == "Water" ? Colors.blue : Pokedex[index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                          : Pokedex[index]['type'][0] == "Electric" ? Colors.amber : Pokedex[index]['type'][0] == "Rock" ? Colors.grey
                          : Pokedex[index]['type'][0] == "Ground" ? Colors.brown : Pokedex[index]['type'][0] == "Psychic" ? Colors.indigo
                          : Pokedex[index]['type'][0] == "Fighting" ? Colors.orange : Pokedex[index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                          : Pokedex[index]['type'][0] == "Ghost" ? Colors.deepPurple : Pokedex[index]['type'][0] == "Normal" ? Colors.white70 : Colors.pink,
                        heroTag: index,
                      )));
                    },
                  ),

                );

              },
            ),
            ):Center(
              child:CircularProgressIndicator(),
            )
          ],
        )
    );


  }
  void fetchPokemonDate() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value)  {
      if(value.statusCode == 200){
        var decodedJsonData  = jsonDecode(value.body);
        Pokedex = decodedJsonData['pokemon'];

        setState(() {

        });
      }
    });
  }
}