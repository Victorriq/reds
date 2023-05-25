import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reds/data/post_json.dart';
import 'package:reds/data/user_json.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<PageController> _pageControllers = [];
  int _currentStoryIndex = 0;
  double _currentProgress = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageControllers = List.generate(usersList.length, (index) => PageController());
    startTimer();
  }

  @override
  void dispose() {
    _pageControllers.forEach((controller) => controller.dispose());
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_currentProgress > 0) {
          _currentProgress -= 1 / 20; // Reduce 1/20th of the progress every second for 20-second duration
        } else {
          goToNextStory();
        }
      });
    });
  }

  void goToNextStory() {
    if (_currentStoryIndex < usersList.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentProgress = 1.0;
        _pageControllers[_currentStoryIndex - 1].animateToPage(
          _currentStoryIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        startTimer();
      });
    } else {
      // Reached the last story, do something (e.g., navigate to a different screen)
    }
  }

  void goToPreviousStory() {
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _currentProgress = 1.0;
        _pageControllers[_currentStoryIndex + 1].animateToPage(
          _currentStoryIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        startTimer();
      });
    } else {
      // Reached the first story, do something (e.g., go back to the previous screen)
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: getAppBar(),
        ),
        body: getBody(),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
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
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Feather.bell,
                color: Colors.black,
                size: 25,
              ),
            ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFFE0DF),
                              Color(0xFFE1F6F4),
                            ],
                          ),
                        ),
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullScreenImagePage(
                                      imageUrl: usersList[index]['img'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(usersList[index]['img']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullScreenImagePage(
                                imageUrl: postsList[index]['postImg'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 288,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: const Offset(0, 1),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(postsList[index]['postImg']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 288,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(postsList[index]['img']),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            postsList[index]['name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            postsList[index]['time'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Entypo.dots_three_vertical,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Feather.heart,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['like'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          MaterialIcons.chat_bubble_outline,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['comment'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: const Color(0xFFE5E5E5).withOpacity(0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          postsList[index]['share'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
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
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({required this.imageUrl});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  int currentIndex = 0;
  List<PageController> _pageControllers = [];
  double progressBarValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageControllers = List.generate(usersList.length, (index) => PageController());
    startProgressBarAnimation();
  }

  @override
  void dispose() {
    _pageControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void startProgressBarAnimation() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        if (progressBarValue < 1.0) {
          progressBarValue += 0.1; // Increase 1/10th of the progress every second for 10-second duration
          startProgressBarAnimation();
        } else {
          if (currentIndex < usersList.length - 1) {
            currentIndex++;
            progressBarValue = 0.0;
            _pageControllers[currentIndex - 1].animateToPage(
              currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            startProgressBarAnimation();
          } else {
            // Reached the last story, do something (e.g., navigate to a different screen)
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageControllers[currentIndex],
              itemCount: usersList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  progressBarValue = 0.0;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return PhotoView(
                  imageProvider: NetworkImage(usersList[index]['img']),
                  loadingBuilder: (context, event) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: LinearProgressIndicator(
                value: progressBarValue,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentIndex > 0) {
                    currentIndex--;
                    progressBarValue = 0.0;
                    _pageControllers[currentIndex + 1].animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    startProgressBarAnimation();
                  } else {
                    // Reached the first story, do something (e.g., go back to the previous screen)
                  }
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (currentIndex < usersList.length - 1) {
                    currentIndex++;
                    progressBarValue = 0.0;
                    _pageControllers[currentIndex - 1].animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    startProgressBarAnimation();
                  } else {
                    // Reached the last story, do something (e.g., navigate to a different screen)
                  }
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
