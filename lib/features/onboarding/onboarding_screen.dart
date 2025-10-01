import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: onboardContentList.length,
                itemBuilder: (BuildContext context, int index) =>
                    OnboardingContent(
                      image: onboardContentList[index].image,
                      title: onboardContentList[index].title,
                    ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Row(
                children: [
                  DotIndicator(),
                  ...List.generate(onboardContentList.length, (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex,),
                  )),
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(microseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false
  });
final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(milliseconds: 300),
      height: isActive ? 12 :4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.lightBlue : Colors.lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}

class OnBoard {
  final String title, image;
  OnBoard({required this.title, required this.image});
}

final List<OnBoard> onboardContentList = [
  OnBoard(
    image: 'assets/animations/waresix truck.json',
    title: 'Explore our services',
  ),
  OnBoard(
    image: 'assets/animations/Learing.json',
    title: 'Explore our services',
  ),
  OnBoard(
    image: 'assets/animations/Warehouse Delivery.json',
    title: 'Explore our services',
  ),
];

class OnboardingContent extends StatelessWidget {
  final String image, title;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(image, width: 400, height: 400),

        Text(
          title,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
