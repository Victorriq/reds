import 'package:flutter/material.dart';
import 'package:reds/reusables/list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int followersCount = 100;
  int followingCount = 200;
  int postsCount = 50;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the Scaffold to black
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center all the elements vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center all the elements horizontally
            children: [
              Container(
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/myke.png'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'usuario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Seguidos',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          followingCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Seguidores',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          followersCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          postsCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Hola! Soy un usuario de la red social y me encanta compartir momentos y experiencias interesantes con mis amigos.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              const SizedBox(height: 16),
              Expanded(
                child: DefaultTabController(
                  length: 5,
                  child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(text: 'Posts'),
                          Tab(text: 'Repost'),
                          Tab(text: 'Tags'),
                          Tab(text: 'Tab 4'),
                          Tab(text: 'Info'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(color: Colors.red),
                            Container(color: Colors.green),
                            Container(color: Colors.blue),
                            Container(color: Colors.yellow),
                            const MyListScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
