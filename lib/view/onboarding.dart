import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_animation/view/widget/animated_container.dart';
import 'package:onboarding_animation/view/widget/container_tile.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Helper: how long to wait on each page
    Duration delayForPage(int page) {
      if (page == 1) return const Duration(seconds: 3); // 3s for page 2
      return const Duration(milliseconds: 2200); // default 2.2s
    }

    // Recursive single-shot timer
    void scheduleNext() {
      _timer = Timer(delayForPage(_currentPage), () async {
        if (_currentPage < 2) {
          _currentPage++;
          await _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 1300),
            curve: Curves.easeInOut,
          );
          if (mounted) scheduleNext(); // schedule next step
        }
      });
    }

    scheduleNext(); // start chain
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const OnboardingPage1(),
      const OnboardingPage2(),
      OnboardingPage3(onGetStarted: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Let's Get Started!")),
        );
      }),
    ];

    return Scaffold(
      backgroundColor: Color(0xfffcf4ec),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: pages,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.green[900]
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedImageCard(
            assetPath: 'images/bg1.png',
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              style: GoogleFonts.merriweather(
                color: Colors.green[900],
                height: 1.15,
              ),
              children: [
                TextSpan(
                  text: "I'm\n",
                  style: GoogleFonts.merriweather(fontSize: 40),
                ),
                TextSpan(
                  text: "Pi",
                  style: GoogleFonts.merriweather(fontSize: 300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Column(
                    children: const [
                      AnimatedImageCard(
                        height: 150,
                        width: 180,
                        assetPath: 'images/computer.jpeg',
                        delay: Duration(milliseconds: 1000),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Two right images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AnimatedImageCard(
                  fit: BoxFit.fill,
                  height: 220,
                  width: 200,
                  assetPath: 'images/ball.jpeg',
                  delay: Duration(milliseconds: 1500),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: AnimatedImageCard(
                    fit: BoxFit.fill,
                    height: 150,
                    width: 200,
                    assetPath: 'images/plane.jpeg',
                    delay: Duration(milliseconds: 2000),
                  ),
                ),
              ],
            ),

            // Center Text
            Center(
              child: Column(
                children: [
                  FadeIn(
                    duration: Duration(seconds: 1),
                    delay: Duration(seconds: 1),
                    child: Text(
                      "Together,",
                      style: GoogleFonts.merriweather(
                        fontStyle: FontStyle.italic,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                  FadeIn(
                    duration: Duration(seconds: 1),
                    delay: Duration(seconds: 2),
                    child: Text(
                      "we can",
                      style: GoogleFonts.merriweather(
                        fontStyle: FontStyle.italic,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Bottom images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: AnimatedImageCard(
                    height: 150,
                    width: 180,
                    assetPath: 'images/bg1.png',
                    delay: Duration(milliseconds: 2000),
                  ),
                ),
                SizedBox(width: 10),
                AnimatedImageCard(
                  height: 150,
                  width: 180,
                  assetPath: 'images/X.jpeg',
                  delay: Duration(milliseconds: 2000),
                ),
              ],
            ),
          ],
        ),
        const Positioned(
            top: 100,
            left: 120,
            child: Tile(
                delay: Duration(seconds: 1),
                icon: '⏰',
                color: Color(0xFFFDE2E4),
                title: 'Keep a journal')),
        const Positioned(
            top: 315,
            right: 30,
            child: Tile(
                delay: Duration(milliseconds: 1500),
                icon: '📝',
                color: Color(0xFFE0F7FA),
                title: 'Make a plan')),
        const Positioned(
            top: 360,
            left: 35,
            child: Tile(
                delay: Duration(milliseconds: 1730),
                icon: '🌱',
                color: Color(0xFFDFFFE2),
                title: 'Learn something new')),
        const Positioned(
            top: 550,
            left: 60,
            child: Tile(
                delay: Duration(milliseconds: 2000),
                icon: '📖',
                color: Color.fromARGB(255, 248, 231, 123),
                title: 'Read a story')),
        const Positioned(
            top: 640,
            right: 100,
            child: Tile(
                delay: Duration(milliseconds: 2500),
                icon: '💬',
                color: Color.fromARGB(255, 246, 112, 132),
                title: 'Just vent')),
      ],
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onGetStarted;

  const OnboardingPage3({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedImageCard(
            height: 400,
            assetPath: 'images/bg3.jpeg',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              "Start talking to Pi",
              style: GoogleFonts.merriweather(
                  fontStyle: FontStyle.italic,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "When you create your account with Pi, you'll able to see and save your conversation history.",
              style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: WidgetStateProperty.all(Colors.green[900]),
              ),
              onPressed: () {},
              child: Text(
                'Sign up',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              )),
          SizedBox(height: 20),
          ElevatedButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(color: Colors.black38), // Black border
                ),
                minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: WidgetStateProperty.all(
                  Color(0xfffcf4ec),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Skip',
                style:
                    GoogleFonts.poppins(color: Colors.green[900], fontSize: 20),
              )),
        ],
      ),
    );
  }
}
