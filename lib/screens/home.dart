import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:reds/data/post_json.dart';
import 'package:reds/data/user_json.dart';
import 'package:flutter/services.dart'; // Importa el paquete flutter/services.dart

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Utiliza el widget WillPopScope para capturar el evento de retroceso
      onWillPop: () async {
        SystemNavigator.pop(); // Cierra la aplicación cuando se presiona el botón de retroceso
        return true; // Devuelve true para permitir que se cierre la aplicación
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child: getAppBar()),
        body: getBody(),
      ),
    );
  }
  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false, // Evita que aparezca la flecha de retroceso
      elevation: 0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Reds",
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Feather.bell,
                  color: Colors.black,
                  size: 25,
                ))
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Feed",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                // story profile
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xFFFFE0DF),
                              Color(0xFFE1F6F4)
                            ])),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: List.generate(usersList.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(usersList[index]['img']),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: List.generate(postsList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: const Offset(0, 1))
                            ],
                            image: DecorationImage(
                                image:
                                    NetworkImage(postsList[index]['postImg']),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                          width: double.infinity,
                          height: 288,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.25))),
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            postsList[index]['img']),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postsList[index]['name'],
                                            style: const TextStyle(
                                                fontSize: 15, color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            postsList[index]['time'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white.withOpacity(0.8)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Icon(
                                    Entypo.dots_three_vertical,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color:
                                            const Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Feather.heart,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['like'],
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color:
                                            const Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          MaterialIcons.chat_bubble_outline,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['comment'],
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color:
                                            const Color(0xFFE5E5E5).withOpacity(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['share'],
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
